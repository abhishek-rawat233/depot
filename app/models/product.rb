
class PriceValidator < ActiveModel::Validator
  def validate(record)
    return if record.price.nil?
    record.errors[:price] << 'is less than or equal to Discount' unless record.price >= record.discount_price
  end
end

class Product < ApplicationRecord
  #1
  has_many :line_items, dependent: :restrict_with_error

  #3
  has_many :carts, through: :line_items

  #4
  scope :enabled, ->{ where(enabled: true) }

  has_many :orders, through: :line_items


  def self.products_in_line_items
    where(id: LineItem.select(:product_id).distinct)
  end

  def self.product_titles_in_line_items
    select(:title).where(id: LineItem.select(:product_id)).to_a
  end


  private
  def default_values
    self.title = 'abc' if self.title == ''
    self.discount_price = price if discount_price.nil?
  end

  validates :description, :image_url, presence: true
  validates :title, length: {minimum: 10}
  validates :description, length: { minimum: 5, maximum: 10, message: 'should be in between 5-10 characters'}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:
    %r{\.(gif|jp(|e)g|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: :discount_price }
  validates_with PriceValidator

  validates :permalink, uniqueness: true
end
