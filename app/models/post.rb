class Post < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :comments, dependant: :destroy
  has_many :likes, dependant: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def recent_comments
    Comment.last(5)
  end

  def update_posts_counter
    user.increment!(:posts_counter)
  end
end
