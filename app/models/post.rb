class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_author_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
