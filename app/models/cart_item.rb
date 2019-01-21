class CartItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :count, presence: true

  def buy
  	@product = Product.find(product_id)
  	@product.count -= count
    update_cart
  end

  def unbuy
  	@product = Product.find(product_id)
  	@product.count += count
  	update_cart
  end

  def update_cart
    @product.update({title: @product.title, price: @product.price, count: @product.count})
  end
  
end