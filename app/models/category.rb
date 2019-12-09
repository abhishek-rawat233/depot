class CategoryValidator < ActiveModel::Validator
  def validate(record)
    is_sub_category = Category.find(record.parent_id).parent_id
    return unless is_sub_category
    record.errors[:parent_id] << "is invalid. Sub-categories can't have sub_categories" if is_sub_category
  end
end

class Category < ApplicationRecord
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", optional: true

  has_many :products, dependent: :restrict_with_error
  has_many :products_of_sub_categories, through: :sub_categories, source: :products

  validates :name, presence: true
  validates :name, uniqueness: true, if: :name?, unless: :parent_id?
  validates_uniqueness_of :name, scope: :parent_id, if: :name?
  validates_with CategoryValidator, if: :parent_id?

  before_destroy :sub_categories_has_products

  private
    def sub_categories_has_products?
      return products_of_sub_categories.present? ? false : true
    end
end
