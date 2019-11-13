class WsersController < ApplicationController
  before_action :set_wser, only: [:show, :edit, :update, :destroy]

  # GET /wsers
  # GET /wsers.json
  def index
    @wsers = Wser.all
  end

  # GET /wsers/1
  # GET /wsers/1.json
  def show
  end

  # GET /wsers/new
  def new
    @wser = Wser.new
  end

  # GET /wsers/1/edit
  def edit
  end

  # POST /wsers
  # POST /wsers.json
  def create
    @wser = Wser.new(wser_params)

    respond_to do |format|
      if @wser.save
        format.html { redirect_to @wser, notice: 'Wser was successfully created.' }
        format.json { render :show, status: :created, location: @wser }
      else
        format.html { render :new }
        format.json { render json: @wser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wsers/1
  # PATCH/PUT /wsers/1.json
  def update
    respond_to do |format|
      if @wser.update(wser_params)
        format.html { redirect_to @wser, notice: 'Wser was successfully updated.' }
        format.json { render :show, status: :ok, location: @wser }
      else
        format.html { render :edit }
        format.json { render json: @wser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wsers/1
  # DELETE /wsers/1.json
  def destroy
    @wser.destroy
    respond_to do |format|
      format.html { redirect_to wsers_url, notice: 'Wser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wser
      @wser = Wser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wser_params
      params.require(:wser).permit(:name, :password, :password_confirmation)
    end
end
