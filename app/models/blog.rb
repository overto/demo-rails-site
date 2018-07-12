class Blog < ApplicationRecord

  has_many :comments, dependent: :destroy

  validates_presence_of :title, :published_date, :author, :content


  paginates_per 5

end
