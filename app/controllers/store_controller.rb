class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end

  def update_ratings
    rating = Rating.where(user_id: @current_user, product_id: params[:product_id].to_i)
    if rating.present?
      rating.update_all(rating: params[:product_rating].to_f)
    else
      Rating.create({rating: params[:product_rating].to_f,
                    user_id: @current_user.id,
                    product_id: params[:product_id].to_i})
    end
    product = Product.find(params[:product_id].to_i)
    render json: { average_rating: product.average_rating }
  end
end
