class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value)
  end

  def url_valid?(url)
    url.match?(/\.(gif|jp(|e)g|png)/)
  end
end

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

  after_initialize :set_default_discount_price, :set_default_title
  scope :enabled, ->{ where(enabled: true) }

  validates :description, :image_url, presence: true
  validates :title, length: {minimum: 10}
  validates :description, length: { minimum: 5, maximum: 10, message: 'should be in between 5-10 characters'}
  validates :title, uniqueness: true
  # Change this to each validator.
  validates :image_url, allow_blank: true, format: {
    with:
    %r{\.(gif|jp(|e)g|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: :discount_price }
  validates_with PriceValidator

  validates :permalink, format: { with: /(?:[a-z0-9]+\-){2,}\w+/,
                                  message: 'enter atleast 3 words separated with hypen(-) and no space and special characters allowed' }
  validates :permalink, uniqueness: true

  private

  def set_default_title
    title = 'abc' if title == ''
  end

  def set_default_discount_price
    discount_price = price if discount_price.nil?
  end

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
