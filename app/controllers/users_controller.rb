class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_user, except: [:new, :create]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  # create new user from data
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome " + @user.username + "!"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit	
  end

  # update user data
  def update
  	if @user.update(user_params)
  	  flash[:success] = "Updated " + @user.username + " successfully!"
  	else
  	end
  end

  def show
  end

  # destroy all items in the user's cart without returning them to the products table
  # this simulates buying all the items in the cart
  def buy
    current_user.cart_items.each do |item|
      item.destroy
    end
    redirect_to edit_cart_item_path(current_user)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "Incorrect user..."
      redirect_to root_path
    end
  end

end