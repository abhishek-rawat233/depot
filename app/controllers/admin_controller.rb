class AdminController < ApplicationController
  include AdminConcerns
  before_action :redirect_non_admin_users
  before_action :select_category, only: :show_products

  def index
    @total_orders = Order.count
  end

  def show_categories
    @categories = Category.all
    render "categories"
  end


  def show_products
    if @category.present?
      @products = @category.get_all_products
    else
      redirect_to categories_path, notice: "no such id present"
    end
  end

  private
    def select_category
      @category = Category.find_by(id: params[:id])
    end

    def redirect_non_admin_users
      redirect_to store_index_path,
        notice: "You don't have privilege to access this section" unless is_user_admin?
    end
end
