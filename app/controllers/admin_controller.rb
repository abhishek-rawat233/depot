class AdminController < ApplicationController
  before_action :is_user_admin?

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
  private
  def is_user_admin
    redirect_to store_index_path, notice: "You don't have privilege to access this section" unless @current_user.role == 'admin'
  end
end
