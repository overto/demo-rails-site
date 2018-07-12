class AddNewsletterToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :newsletter, :boolean, default: false
  end
end
