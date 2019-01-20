class SessionsController < ApplicationController

  def new

  end

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

  def destroy
  	session[:user_id] = nil
  	flash[:success] = "Logged Out..."
  	redirect_to root_path
  end

end