# class UrlValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#    record.errors[attribute] << "is not valid" unless value =~ /regex/
#   end
# end

class PriceValidator < ActiveModel::Validator
  def validate(record)
    return if record.price.nil?
    record.errors[:price] << 'is less than or equal to Discount' unless record.price >= record.discount_price
  end
end

class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error #, before_remove: :ensure_not_referenced_by_any_line_item
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items
  # before_destroy :ensure_not_referenced_by_any_line_item
  after_initialize :default_values
  belongs_to :category, counter_cache: :products_count
  # after_create :category_counter
  after_update :category_counter
  # belongs_to :sub_category
  # frozen_string_literal: true

  private
  def default_values
    self.title = 'abc' if self.title == ''
    self.discount_price = price if discount_price.nil?
  end

  validates :description, :image_url, presence: true
  # validates :title, :description, :image_url, presence: true #to satify empty title callback this has been commented out
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

  validates :permalink, format: { without:  /[^a-z0-9\-]+/i,
                                  message: 'no space and special characters allowed'}
  validates :permalink, format: { with: /(?:\w+\-){2,}\w+/,
                                  message: 'enter atleast 3 words separated with hypen(-)' }
  validates :permalink, uniqueness: true

  def category_counter
    parent_category = Category.find(category_id).parent
    if parent_category.present?
      Category.increment_counter(:products_count, parent_category)
    end
  end

end
