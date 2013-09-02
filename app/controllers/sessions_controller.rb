class SessionsController < ApplicationController
  def create
    user = User.find_by_netID(params[:netID]) ||
    School.find_by_name("NYUAD").users.create(name: params[:name], netID: params[:netID], 
                                              nyu_token: params[:nyu_token], refresh_token: params[:refresh_token],
                                              email: "#{params[:netID]}@nyu.edu", display_image: '/assets/nyuad.jpg')
    if user.nyu_token.nil? || user.refresh_token.nil?
      user.nyu_token = params[:nyu_token]
      user.refresh_token = params[:refresh_token]
      user.save!
    end
    session[:user_id] = user
    cookies[:remember_token] = {value: user.remember_token, expires: 1.year.from_now }
    redirect_to root_url
  end
    
  def facebook_create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user.email = session[:email]
    user.save!
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end
  def destroy
    session[:user_id] = nil
    cookies.delete(:remember_token)
    redirect_to "https://accounts.google.com/logout" 
  end
  def nyu_create
    auth_url = "https://accounts.google.com/o/oauth2/auth?response_type=code&hd=nyu.edu&client_id=#{ENV['CLIENT_ID']}&redirect_uri=#{ENV['HOSTNAME']}/oauth2callback&access_type=offline&scope=https://www.googleapis.com/auth/calendar%20https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/userinfo.profile"
    redirect_to auth_url
  end
  def nyu_callback
    if params[:code]
      access_token, refresh_token = User.get_token params[:code]
      info = JSON.parse HTTParty.get("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{access_token}").to_json
      netID = info["email"].match(/^([^@]+)/)[0]
      name = info["name"]
      redirect_to controller: "sessions", action: "create", 
        netID: netID, name: name, nyu_token: access_token, refresh_token: refresh_token
    else
      redirect_to root_url, notice: "Authorization Failure"
    end

  end
end
