class ReportsController < ApplicationController
  def index(from = 5.days.ago, to = Date.tomorrow)#instead of today tomorrow else this doesn't show orders that were created today
    @orders = Order.where(created_at: from..to)
  end
end
