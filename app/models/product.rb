class PriceValidator < ActiveModel::Validator
  def validate(record)
    return if record.price.nil?
    record.errors[:price] << 'is less than or equal to Discount' unless record.price >= record.discount_price
  end
end

class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items

  after_initialize :default_values
  belongs_to :category, counter_cache: :products_count

  after_update :category_counter

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

  private
  def default_values
    self.title = 'abc' if self.title == ''
    self.discount_price = price if discount_price.nil?
  end

  def category_counter
    parent_category = Category.find(category_id).parent
    if parent_category.present?
      Category.increment_counter(:count, parent_category)
    end
  end

end
