 class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # index for diplaying all products
  def index
    @products = Product.all
  end

  # create new product
  def new
    @product = Product.new
  end

  def edit
  end

  # create a new product from data
  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      flash[:notice] = "Product was successfully created"
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  #  update product with supplied data
  def update
    if @product.update(product_params)
      flash[:notice] = "Product was successfully updated" + params.inspect
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def show
  end

  # remove product from table
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
    	flash[:notice] = "Product " + @product.id.to_s + " has been destroyed!"
    	redirect_to products_path
    end
  end

  private 
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price, :count)
    end

    def require_same_user
      if current_user != @product.user
        flash[:danger] = "Incorrect user..."
        redirect_to root_path
      end
    end

 end