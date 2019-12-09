class ReportsController < ApplicationController
  def index(from = Date.today - 5, to = Date.tomorrow)#instead of today tomorrow else this doesn't show orders that were created today
    @orders = Order.where(created_at: from..to)
  end
end
