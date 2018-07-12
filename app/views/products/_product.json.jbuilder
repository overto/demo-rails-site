json.extract! product, :id, :name, :description, :quantity_on_hand, :selling_price, :cost_of_product, :shipping_weight, :product_thumbnail_image_url, :product_fullsize_image_url, :created_at, :updated_at
json.url product_url(product, format: :json)
