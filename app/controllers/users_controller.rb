class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :set_user_address, only: [:create, :update]
  layout "myorders", only: [:orders, :lineItems]
  before_action :pagination, only: [:lineItems]

  def index
    @users = User.order(:name)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def orders
    @orders = Order.where(user_id: @current_user.id)
  end

  def lineItems()
    @current_page ||= 1
    page_first_item = ITEMS_PER_PAGE * (@current_page - 1) + 1
    page_last_item = ITEMS_PER_PAGE * @current_page
    @line_items = @current_user.line_items[page_first_item, page_last_item]
  end

  def pagination
    @current_page = params[:page_number].to_i unless params[:page_number].nil?
    @first_page = 1
    @last_page = (@current_user.line_items.count.to_f/ITEMS_PER_PAGE).ceil
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User #{@user.name} was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  rescue_from 'User::Error' do |exception|
    redirect_to users_url, notice: exception.message
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_user_address
      address_params = get_address_params
      if Address.where(user_id: @user.id).present?
        Address.find(user_id: @user.id).update(address_params)
      else
        Address.create(address_params)
      end
    end

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email)
    end

    def get_address_params
      address_params = params.require(:user).permit(:city, :state, :country, :pincode)
      address_params[:user_id] = @user.id
      return address_params
    end
end
