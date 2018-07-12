class Product < ApplicationRecord

  has_many :reviews, dependent: :destroy

  validates_presence_of :name, :description, :quantity_on_hand, :selling_price, :cost_of_product, :shipping_weight, :product_thumbnail_image_url, :product_fullsize_image_url

  validates_numericality_of :quantity_on_hand, :greater_than_or_equal_to => 0

  validates_numericality_of :selling_price, :cost_of_product, :shipping_weight, :greater_than => 0

  paginates_per 5

end
