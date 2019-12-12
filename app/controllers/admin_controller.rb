class AdminController < ApplicationController
  before_action :is_user_admin?

  def index#(from = Date.today - 5, to = Date.today)
    @total_orders = Order.count
    # user = User.find(params[:user_id])
    # @orders = Order.where(created_at: from..to)
  end

  def show_categories
    @category = Category.all
    render "categories" if @current_user.role == 'admin'
  end

  private
    def is_user_admin
      redirect_to store_index_path, notice: "You don't have privilege to access this section" unless @current_user.role == 'admin'
    end
end
