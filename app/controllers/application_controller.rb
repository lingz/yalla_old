class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def default_url_options
    if Rails.env.production?
      { :host => "yalla.nyuad.org"}
    else
      {:host => "localhost", port: 3000}
    end
  end
  def current_user
    @_current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
    if !@_current_user
      @_current_user = cookies[:remember_token] && User.find_by_remember_token(cookies[:remember_token])
    end
    @_current_user
  end

  def user_agent
    string = request.env["HTTP_USER_AGENT"]

    if string[/(Mobile\/.+Safari)|(AppleWebKit\/.+Mobile)/]
      return "iOS"
    elsif string[/Android/]
      return "Android"
    else
      return "None"
    end

  end

  def session_show
    @session = session
  end
	
  helper_method :current_user
  helper_method :user_agent
  helper_method :session_show
end
