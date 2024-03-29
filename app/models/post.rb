class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :user, class_name: 'User', foreign_key: 'author_id', counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_likes_count
    update(likes_counter: likes.count)
  end

  def increment_posts_counter
    update(posts_counter: posts_counter + 1)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
