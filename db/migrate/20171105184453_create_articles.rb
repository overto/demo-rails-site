class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.date :published_date
      t.boolean :is_published
      t.text :content
      t.string :author_thumbnail_avatar_url

      t.timestamps
    end
  end
end
