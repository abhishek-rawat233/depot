class AdminController < ApplicationController
  # before_action : #think more about serialization in show categories 

  def index#(from = Date.today - 5, to = Date.today)
    @total_orders = Order.count
    redirect_to store_index_path, notice: "You don't have privilege to access this section" unless @current_user.role == 'admin'
    # user = User.find(params[:user_id])
    # @orders = Order.where(created_at: from..to)
  end

  def show_categories
    @category = Category.all
    #remove this line and place this under admin namespace
    unless @current_user.role == 'admin'
      redirect_to store_index_path, notice: "You don't have privilege to access this section"
    else
      render "categories"
    end
  end

  # private

end
