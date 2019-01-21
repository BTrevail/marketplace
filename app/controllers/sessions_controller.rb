class SessionsController < ApplicationController

  def new
  end

  # creates a new session for user authentication
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Login successful"
      redirect_to products_path
    else
      flash.now[:danger] = "Invalid user information!"
      render 'new'
    end
  end

  # Destroys session on user logout
  def destroy
  	session[:user_id] = nil
  	flash[:success] = "Logged Out..."
  	redirect_to root_path
  end

end