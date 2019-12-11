class Category < ApplicationRecord
  #exercise
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Category", optional: true

  has_many :products, dependent: :restrict_with_error
  has_many :products_of_sub_categories, through: :sub_categories, source: :products

  validates :name, presence: true
  validates :name, uniqueness: true, if: :name?, unless: :parent_id?
  validates_uniqueness_of :name, scope: :parent_id, if: :name?

  before_destroy :sub_categories_has_products
  before_save :parent_cannot_be_subcategory, if: :parent_id?

  private
    def parent_cannot_be_subcategory
      return unless parent.parent.present?
      errors[:parent_id] << "is invalid. Sub-categories can't have sub_categories"
      throw :abort
    end

    def sub_categories_has_products?
      throw :abort unless products_of_sub_categories.present?
    end
end
