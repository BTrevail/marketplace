class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user, :is_logged_in

  # returns the current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # determines whith the user is logged in
  def is_logged_in
    !!current_user
  end

  # Used to require a user to be logged in to certain pages
  def require_user
    if !is_logged_in
      flash[:danger] = "Must log in!"
      redirect_to root_path
    end
  end

end
