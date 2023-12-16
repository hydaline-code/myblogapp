class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :comments_counter, optional: true

  after_create :update_post_comments_count

  private

  def update_post_comments_count
    post.update(comments_counter: post.comments.count)
  end
end
