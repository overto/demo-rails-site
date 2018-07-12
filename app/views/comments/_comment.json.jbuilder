json.extract! comment, :id, :author, :content, :avatar_image, :rating, :blog_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
