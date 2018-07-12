class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.date :published_date
      t.string :author
      t.text :content

      t.timestamps
    end
  end
end
