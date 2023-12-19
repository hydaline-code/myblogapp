# class Like < ApplicationRecord
#   belongs_to :user
#   belongs_to :post, counter_cache: true

#   after_create :update_post_likes_counter
#   def update_post_likes_counter
#     post.update(likes_counter: post.likes.count)
#   end
# end

class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user, class_name: 'User'
  after_save :update_likes_counter

  private

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
