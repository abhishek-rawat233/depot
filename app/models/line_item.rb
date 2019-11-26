class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  # belongs_to :user
  belongs_to :product, optional: true
  belongs_to :cart, counter_cache: :line_items_count

  validates_uniqueness_of :product_id, scope: :cart_id
  validates :quantity, numericality: { less_than_or_equal_to: 1 , message: 'maximum quantity is one' }

  def total_price
    product.price * quantity
  end
end
