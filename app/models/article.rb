class Article < ApplicationRecord

  validates :title, :author, :content, presence: true
  validates :published_date, presence: true, if: :is_published?
  validates :is_published, presence: true, if: :published_date?

  validate :validate_pub_date

  private

  def validate_pub_date
    if published_date != nil
      if published_date > Date.today
      errors.add(:published_date, 'should be in the past')
      end
    end
  end

  paginates_per 5

  after_save do |article|
    if article.is_published?
      User.where(newsletter: true).each do |user|
        UserMailer.article_email(user, article).deliver_now
      end
    end
  end

end
