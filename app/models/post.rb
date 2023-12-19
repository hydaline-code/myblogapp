class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id', counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_likes_count
    update(likes_counter: likes.count)
  end
  # def update_post_likes_counter
  #   post.update(likes_counter: post.likes.counter)
  # end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
