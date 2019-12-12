class AdminController < ApplicationController

  def index
    @total_orders = Order.count
  end

  def show_categories
    @category = Category.all
    render "categories" if @current_user.role = 'admin'
  end

  def show_products
    category = Category.where(id: params[:id])
    if category.present?
      @products = category.products + category.products_of_sub_categories
    else
      redirect_to categories_path, notice: "no such id present"
    end
  end
  # private

end
