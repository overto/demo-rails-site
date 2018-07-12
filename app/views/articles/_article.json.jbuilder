json.extract! article, :id, :title, :author, :published_date, :is_published, :content, :author_thumbnail_avatar_url, :created_at, :updated_at
json.url article_url(article, format: :json)
