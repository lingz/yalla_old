class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def default_url_options
    if Rails.env.production?
      { :host => "yalla.herokuapp.com"}
    else
      {:host => "localhost:3000"}
    end
  end
  def current_user
    @_current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
    if !@_current_user
      @_current_user = cookies[:remember_token] && User.find_by_remember_token(cookies[:remember_token])
    end
    @_current_user
  end

  def session_show
    @session = session
  end
	
  helper_method :current_user
  helper_method :session_show
end
