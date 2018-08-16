class ProductsController < ApplicationController
  before_action :find_product, only:[:edit, :update, :show, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      params[:file] && params[:file].each do |f|
        @product.images.create(avatar: params[:file][f])
      end
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      if params[:file].present?
        @product.images.destroy_all
        params[:file] && params[:file].each do |f|
          @product.images.create(avatar: params[:file][f])
        end
      end
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    end
  end

  private

  def product_params
    params.permit(:name, :description)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
