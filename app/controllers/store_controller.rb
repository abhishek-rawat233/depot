class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  before_action :set_rating, only: :update_ratings
  before_action :set_product, only: :update_ratings
  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end

  def update_ratings
    if @rating.present?
      @rating.update(rating: params[:product_rating].to_f)
    else
      Rating.create({rating: params[:product_rating].to_f,
                    user_id: @current_user.id,
                    product_id: params[:product_id].to_i})
    end
    render json: { average_rating: @product.average_rating }
  end

  def set_rating
    @rating = Rating.where(user_id: @current_user, product_id: params[:product_id].to_i)
  end

  def set_product
    @product = Product.find(params[:product_id].to_i)
  end
end
