class Puzzle < ApplicationRecord

  validates_presence_of :puzzle_name, :word_list

  paginates_per 5

end
