class SessionsController < ApplicationController
  def create
    user = User.find_by_netID(params[:netID]) ||
    School.find_by_name("NYUAD").users.create(name: params[:name], netID: params[:netID],
                nyu_class: params[:nyu_class], nyu_token: params[:nyu_token],
                email: "#{params[:netID]}@nyu.edu", display_image: '/assets/nyuad.jpg')
    session[:user_id] = user
    cookies.permanent[:remember_token] = user.remember_token
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
    redirect_to "http://passport.sg.nyuad.org/auth/logout" 
  end
  def nyu_create
    client = OAuth2::Client.new('W6zBUB3r2e90r0w24ts01seg3', '98j08jpiupiuy7dfy3yn', 
                                site: 'http://passport.sg.nyuad.org/', 
                                authorize_url: "/visa/oauth/authorize", token_url: "/visa/oauth/token")
    auth_url = client.auth_code.authorize_url(redirect_uri: root_url + '/auth/nyu/callback')
    redirect_to auth_url
  end
  def nyu_callback
    client = OAuth2::Client.new('W6zBUB3r2e90r0w24ts01seg3', '98j08jpiupiuy7dfy3yn', 
                                site: 'http://passport.sg.nyuad.org/', 
                                authorize_url: "/visa/oauth/authorize", token_url: "/visa/oauth/token")
    if params[:code]
      token = client.auth_code.get_token(params[:code])
      response = JSON.parse token.get('/visa/use/info/me').body
      redirect_to controller: "sessions", action: "create", 
        netID: response['netID'], name: response['name'], nyu_class: response['class'],
        nyu_token: token.token
    else
      redirect_to root_url, notice: "Authorization Failure"
    end
  end
end
