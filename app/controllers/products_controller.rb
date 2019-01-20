 class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = "Product was successfully created"
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Product was successfully updated"
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def show
  end

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

 end