class Review < ApplicationRecord
  belongs_to :product

  validates_presence_of :author, :comment, :rating

  validates_numericality_of :rating, less_than_or_equal_to: 10, greater_than_or_equal_to: 1

end
