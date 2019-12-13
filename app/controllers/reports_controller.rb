class ReportsController < ApplicationController
  include ReportConcerns
  before_action :set_from_and_to

  def index(from = @from, to = @to)
    @orders = Order.where(created_at: from..to)
  end
end
