class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [ :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:update, :destroy]

  # used to pass user to the user's cart page
  def edit
  	@user = current_user
  end

  # used to create a new item in the cart
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user = current_user

    if is_enough && @cart_item.save
      @cart_item.buy # pre-emtively "buys" the item to save it from other users
      flash[:notice] = "Item was added to cart!"
    else
      flash[:danger] = "Item could not be added to cart!"
    end
    redirect_to products_path
  end

  # updates the number of the item in the cart
  def update
  	@cart_item.count -= CartItem.find(@cart_item.id).count

    if is_enough && @cart_item.update(cart_item_params)
      @cart_item.buy # pre-emtively "buys" the item to save it from other users
      flash[:notice] = "Item was successfully updated!"
    else
      flash[:danger] = "Item could not be updated!" + params.inspect
    end
    redirect_to edit_cart_item_path(@cart_item)
  end

  # removes the item from the cart
  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
    	@cart_item.unbuy # returns unbought items in the cart to products table
    	flash[:notice] = "Item has been removed from cart!"
    end
    redirect_to edit_cart_item_path(@cart_item)
  end

private 
  # check if there are enough of an item to be bought
  def is_enough
  	Product.find(@cart_item.product_id).count - @cart_item.count >= 0
  end

  # sets the cart_item
  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  # requirements for the cart_item parameters
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :user_id, :count)
  end

  # require the same user for some actions
  def require_same_user
    if current_user != @cart_item.user
      flash[:danger] = "Incorrect user..."
	  redirect_to root_path
    end
  end
end