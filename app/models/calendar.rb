class Calendar < ActiveRecord::Base
  attr_accessible :access_token, :client_id, :client_secret, :code, :redirect_uri, :refresh_token, :calendar_id

  def self.update_token
    @calendar = Calendar.find(1)
    data = {
      client_id: @calendar.client_id,
      client_secret: @calendar.client_secret,
      refresh_token: @calendar.refresh_token,
      grant_type: "refresh_token"
    }
    @response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    if @response["access_token"].present?
      @calendar.access_token = @response["access_token"]
      puts "access token updated"
      puts @response["access_token"]
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
    HTTParty.get("https://www.googleapis.com/calendar/v3/calendars/#{@calendar.calendar_id}/\
                  events")
  end
end
