class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  after_action :set_image_collection, only: [:create, :update]

  def index
    @products = Product.all
  end

  def show
    # @products_extra_images = @product.images.map { |image| (image.image_url) }
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        puts @product.errors.full_messages
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all
        ActionCable.server.broadcast 'products', html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to products_url, notice: @product.errors.full_messages }
      end
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    def set_image_collection
      uploaded_images = get_uploaded_images
      if @product.images.length == IMAGE_SET_LIMIT && uploaded_images.present?
        render :edit, notice: "no more images can be uploaded"
      end
      remaining_images_allocation = IMAGE_SET_LIMIT - @product.images.length
      uploaded_images[0...remaining_images_allocation].each do |image|
      @product.images.create({image_url: image.original_filename})
      end
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def get_uploaded_images
      params[:product][:extra_images]
    end

    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :enabled, :discount_price, :permalink, :category_id)
    end
end
