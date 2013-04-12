class Calendar < ActiveRecord::Base
  attr_accessible :access_token, :client_id, :client_secret, :code, :redirect_uri,
    :refresh_token, :calendar_id, :last_update, :calls
  
  def self.update_token
    @calendar = Calendar.find(1)
    data = {
      client_id: @calendar.client_id,
      client_secret: @calendar.client_secret,
      refresh_token: @calendar.refresh_token,
      grant_type: "refresh_token"
    }
    @response = HTTParty.post("https://accounts.google.com/o/oauth2/token",
                              body: data)
    puts(@response)
    if @response["access_token"].present?
      @calendar.access_token = @response["access_token"]
      puts "access token updated"
      puts @response["access_token"]
      @calendar.save!
    else
      puts "no token"
    end
  rescue RestClient::BadRequest => e
    puts e
  rescue
    puts "unknown error"
  end
  
  def self.calendar_update
    @calendar = Calendar.find(1)
    events = self.events_list
    @calendar.last_update = DateTime.now
    @calendar.save!
    
    #check if events exist at all
    if !events.nil? 
    events.each do |event|
      #if the events are confirmed, then create / update them
      if event["status"] != "cancelled"
        params = {name: event["summary"],
          location: event["location"],
          description: event["description"],
          unique_id: event["iCalUID"],
          ids: event["id"],
          status: event["status"]}
        # if event starts and ends on a different day
        if event["start"]["date"]
          params[:start_time] = event["start"]["date"].to_datetime
          params[:end_time] = event["end"]["date"].to_datetime
        # if event starts and ends on the same day
        else
          params[:start_time] = event["start"]["dateTime"].to_datetime
          params[:end_time] = event["end"]["dateTime"].to_datetime
        end
        user = User.find_by_email(event["creator"]["email"]) || 
          User.create_with_netID(event["creator"]["email"].match(/(.*?)@nyu.edu/)[0][$1])
        # check if the user exists in the system (so that have permission to be added) 
        # Bounce off Oauth to see if email address is valid
        puts user
        
        if user
          params[:user_id] =  user.id
          old_event = Event.find_by_unique_id(params[:unique_id])
          # if the event already exists, update it
          if old_event
            # update attendance links
            event["attendees"].each do |attendee|
              # ignore this for the host and the events system
              if attendee["email"] != "nyuad.yalla@gmail.com" and attendee["email"] != user.email
                # search for if the attendee has an account or is in nyuad
                attendee_user = User.find_by_email(attendee["email"]) || User.create_with_netID(attendee["email"].match(/(.*?)@nyu.edu/)[0][$1])
                # if the attendee has an account in the system
                if attendee_user
                  # search for the link in the system
                  link = UserEvent.find_by_event_id_and_user_id(old_event.id, attendee_user.id)
                  # if the user is accepted
                  if attendee["responseStatus"] != "declined"
                    old_event.user_events.create(user_id: attendee_user.id, status: "true") if !link
                  # the event has been declined
                  elsif link
                    link.status = "false"
                    link.save!
                  end
                else
                  link = UserEvent.find_by_email_and_name(attendee["email"], attendee["displayName"])
                  if attendee["responseStatus"] != "declined"
                    old_event.user_events.create(email: attendee["email"], name: attendee["displayName"], status:"true") if !link
                  elsif link
                    link.status = "false"
                    link.save!
                  end
                end
              end
            end
            old_event.update_attributes(params)
            old_event.save!
          # otherwise create a new event
          else
            user.events.create(params)
          end
        else
          puts("event #{event["summary"]} not created because creator #{event["creator"]["email"]} is not a registered user")
        end
      elsif event["status"] == "cancelled" 
        event = Event.find_by_unique_id(event["iCalUID"])
        if event
          event.destroy
        end
      else
        puts("Error:unhandled event state")
      end
    end
    end
  end

  def self.events_list
    @calendar = Calendar.find(1)
    puts("https://www.googleapis.com/calendar/v3/calendars/\
#{@calendar.calendar_id}/events?access_token=#{@calendar.access_token}\
&timeMin=#{DateTime.now.strftime('%Y-%m-%dT%H:%M:%SZ')}&updatedMin=#{@calendar.last_update.strftime('%Y-%m-%dT%H:%M:%SZ')}\
&showDeleted=true")
    
    client, service = self.get_client
    
    result = client.execute(api_method: service.events.list,
                            parameters: {'calendarId' => @calendar.calendar_id,
                                         'timeMin' => DateTime.now.strftime('%Y-%m-%dT%H:%M:%SZ'),
                                         'updatedMin' => @calendar.last_update.strftime('%Y-%m-%dT%H:%M:%SZ'),
                                         'showDeleted' => true})
    events_list = result.data.items
  end

  def self.add_person(eventID, userID)
    user = User.find_by_id(userID)
    event = Event.find_by_id(eventID)
    if !user or !event
      return true
    end
    user_event = UserEvent.find_by_user_id_and_event_id_and_status(user.id, event.id, "true")
    if user.nyu_token
      Rails.logger.info("calling 1")
      @calendar = Calendar.find(1)

      client, service = self.get_user_client(event.user.id)
      if !client or !service
        Rails.logger.info("calling 9")
        event.user_events.create(user_id: user.id, status: "failed")
        return false
      end
        

      result = client.execute(:api_method => service.events.list,
                          :parameters => {'calendarId' => event.user.email, 'iCalUID' => event.unique_id})
      result = result.data.items[0]
      ids = result.id
      if !user_event
        Rails.logger.info("calling 2")
        new_person = result.attendees[0].class.new
        new_person.email = user.email
        new_person.display_name = user.name
        new_person.response_status = "accepted"
        result.attendees = result.attendees << new_person
      else
        result.attendees = result.attendees.delete_if {|attendee| attendee.email == user.email }
        user_event.destroy
      end
      result = client.execute(:api_method => service.events.update,
                              :parameters => {'calendarId' => event.user.email, 'eventId' => ids, 'sendNotifications' => true},
                              :body_object => result,
                              :headers => {'Content-Type' => 'application/json'})
      Rails.logger.info(result.data.to_json)
      if !result.data.to_json[/Calendar usage limits exceeded/].nil?
        @calendar.failures = @calendar.failures + 1
        @calendar.save!
        event.user_events.create(user_id: user.id, status: "failed")
        Rails.logger.info("calling 3")
        return false
      else
        Rails.logger.info("calling 4")
        event.user_events.create(user_id: user.id, status: "true")
        return true
      end
    else
      Rails.logger.info("calling 5")
      event.user_events.create(user_id: user.id, status: "failed")
      return false
    end
  end

  def self.get_client
    require 'google/api_client'

    @calendar = Calendar.find(1)
    @calendar.calls += 1
    @calendar.save!

    client = Google::APIClient.new
    client.authorization.client_id = "759068570332.apps.googleusercontent.com"
    client.authorization.client_secret = "7amw71XAAyReH92K_LtOp5-a"
    client.authorization.scope = "https://www.googleapis.com/auth/calendar"
    client.authorization.refresh_token = @calendar.refresh_token
    client.authorization.access_token = @calendar.access_token

    service = client.discovered_api('calendar','v3')

    return client, service
  end

  # get the client and service for the individual user
  def self.get_user_client(userId)
    require 'google/api_client'
    user = User.find_by_id(userId)
    if !user or !user.nyu_token
      return false, false
    end
    request_url = "http://passport.sg.nyuad.org/visa/google/token?access_token=" + user.nyu_token
    token = HTTParty.get(request_url).parsed_response
    if token["error"]
      return false, false
    end
    client = Google::APIClient.new
    client.authorization.scope = "https://www.googleapis.com/auth/calendar"
    client.authorization.access_token = token["access_token"]
    service = client.discovered_api('calendar','v3')
    return client, service
  end

  def self.cleanup
    Event.all.each do |event|
      event.destroy if event.end_time < DateTime.now.advance(hours: 1)
    end
  end

  def self.retry_old
    UserEvent.find(:all, conditions: {status: :failed}).each do |user_event|
      state = self.add_person(user_event.event_id, user_event.user_id)
      user_event.destroy
      if !state
        return false
      end
    end
    return true
  end

end
