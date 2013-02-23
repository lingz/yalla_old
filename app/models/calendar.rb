class Calendar < ActiveRecord::Base
  attr_accessible :access_token, :client_id, :client_secret, :code, :redirect_uri,
    :refresh_token, :calendar_id, :last_update

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
    events = self.events_list
    for events.each do |event|
      email = Email.find_by_address(event["creator"]["email"])
      if email
        user = email.user
        params = {name: event["summary"],
          user_id: user.id,
          location: event["location"],
          description: event["description"],
          unique_id: event["iCalUID"]}
        if event["start"]["date"]
          params[:start_time] = event["start"]["date"].to_datetime
          params[:end_time] = event["end"]["date"].to_datetime
        else
          params[:start_time] = event["start"]["dateTime"].to_datetime
          params[:end_time] = event["end"]["dateTime"].to_datetime
        end
        user.events.create(params)
      else
        raise "event #{event["summary"]} not created because creator is not a registered user"
      end
    end
  end

  def self.events_list
    @calendar = Calendar.find(1)
    puts("https://www.googleapis.com/calendar/v3/calendars/\
#{@calendar.calendar_id}/events?access_token=#{@calendar.access_token}\
&timeMin=#{DateTime.now.advance(hours: 4).strftime('%Y-%m-%dT%H:%M:%SZ')}&updatedMin=#{@calendar.last_update.strftime('%Y-%m-%dT%H:%M:%SZ')}")
    event_list = HTTParty.get("https://www.googleapis.com/calendar/v3/calendars/\
#{@calendar.calendar_id}/events?access_token=#{@calendar.access_token}\
&timeMin=#{DateTime.now.advance(hours: 4).strftime('%Y-%m-%dT%H:%M:%SZ')}&updatedMin=#{@calendar.last_update.strftime('%Y-%m-%dT%H:%M:%SZ')}")
    @calendar.last_update = DateTime.now
    @calendar.save!
    event_list["items"]
  end

end
