class CreatePuzzles < ActiveRecord::Migration[5.1]
  def change
    create_table :puzzles do |t|
      t.string :puzzle_name
      t.text :word_list

      t.timestamps
    end
  end
end
