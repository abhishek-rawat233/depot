class ReportsController < ApplicationController
  include ReportConcerns
  before_action :set_from_and_to

  def index
    @orders = Order.by_date(params[:from], params[:to])
  end

  def create
  end
end
