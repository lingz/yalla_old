class PagesController < ApplicationController
  @@secret1 = "2pTeyptHNYE4UAFRsrbfaYkuVn"
  @@secret2 = "8iCGlwNYl7QrSQcNwEL9D7GMrt"
  @@secret3 = "KyUcA06BZCcAk2m3FDx4JhYOzP"
  @@secret4 = "X5PfFoPon7n1v1PlYr8OhZjslx"
  layout false, except: :about
  def faq
  end

  def passthrough
    if params[:secret]
      if params[:secret] == @@secret1
        user = User.find_by_name("Guest 1")
        @_current_user = user 
        session[:user_id] = user.id
      elsif params[:secret] == @@secret2
        user = User.find_by_name("Guest 2")
        @_current_user = user 
        session[:user_id] = user.id
      elsif params[:secret] == @@secret3
        user = User.find_by_name("Guest 3")
        @_current_user = user 
        session[:user_id] = user.id
      elsif params[:secret] == @@secret4
        user = User.find_by_name("Guest 4")
        @_current_user = user 
        session[:user_id] = user.id
      end
    end
    
    redirect_to "/"
  end

  def about
  end
end
