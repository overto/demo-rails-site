class Comment < ApplicationRecord
  belongs_to :blog

  validates_presence_of :author, :content, :avatar_image, :rating

  validates_numericality_of :rating, less_than_or_equal_to: 5, greater_than_or_equal_to: 1


end
