json.extract! review, :id, :author, :comment, :rating, :product_id, :created_at, :updated_at
json.url review_url(review, format: :json)
