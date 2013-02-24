class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @_current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
  end

  def current_email
    @_email ||= session[:email]
  end
	
  helper_method :current_user
end
