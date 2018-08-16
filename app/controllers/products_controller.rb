class ProductsController < ApplicationController
  before_action :find_product, only:[:edit, :update, :show, :destroy, :remove_image]

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
    @images ={}
    @product.images.each_with_index do |image, i|
      @images[i] = {image_id: image.id,
                    product_id: @product.id,
                    image_name: image.avatar_file_name,
                    image_type: image.avatar_content_type,
                    image_size: image.avatar_file_size,
                    image_url: image.avatar.url,
                    id_of_image: image.id}
    end
    @images = @images.to_json
  end

  def update
    if @product.update(product_params)
      if params[:file].present?
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

  def remove_image
    @image = @product.images.find(params[:image_id])
    if @image.destroy
      respond_to do |format|
        format.js
      end
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
