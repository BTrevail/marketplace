class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [ :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:update, :destroy]

  def edit
  	@user = current_user
  end

  def create

    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user = current_user

    if is_enough && @cart_item.save
      @cart_item.buy
      flash[:notice] = "Item was added to cart!"
    else
      flash[:danger] = "Item could not be added to cart!"
    end
    redirect_to products_path
  end

  def update
  	@cart_item.count -= CartItem.find(@cart_item.id).count

    if is_enough && @cart_item.update(cart_item_params)
      @cart_item.buy
      flash[:notice] = "Item was successfully updated!"
    else
      flash[:danger] = "Item could not be updated!" + params.inspect
    end
    redirect_to edit_cart_item_path(@cart_item)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
    	@cart_item.unbuy
    	flash[:notice] = "Item has been removed from cart!"
    end
    redirect_to edit_cart_item_path(@cart_item)
  end

private 
  def is_enough
  	Product.find(@cart_item.product_id).count - @cart_item.count >= 0
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :user_id, :count)
  end

  def require_same_user
    if current_user != @cart_item.user
      flash[:danger] = "Incorrect user..."
	  redirect_to root_path
    end
  end
end