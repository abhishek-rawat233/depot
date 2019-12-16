class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  #validates :user_id, uniqueness: true, scope: :product_id
  validates :rating, numericality: {greater_than_or_equal_to: 0}
end
