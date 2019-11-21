class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart

  validates_uniqueness_of :product_id, scope: :cart_id
  # debugger
  validates :quantity, numericality: { less_than_or_equal_to: 1 , message: 'maximum quantity is one' }
  # validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true

  def total_price
    product.price * quantity
  end
end
