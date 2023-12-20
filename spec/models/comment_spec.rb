require 'rails_helper'


RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'should belong to a user' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post1', comments_counter: 0)
      post.save
      comment = Comment.new(post: post, text: 'new comment test!')
      expect(comment).to_not be_valid
    end
    it 'can be created without a post, but must have a user' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      user.save
      comment = Comment.new(user: user, text: 'This is a comment')
      expect(comment).to be_valid
    end
    it 'updates the post comments_counter' do
      user = User.new(name: 'hyda', photo_link: 'url', bio: 'developer', posts_counter: 0)
      user.save
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post1', comments_counter: 0,likes_counter: 0)
      post.save
      comment = Comment.new(post: post, user: user, text: 'new comment test!')
    
      expect(comment).to be_valid
    
      puts "Before update: post.comments_counter = #{post.comments_counter}"
      comment.save
      puts "After update: post.comments_counter = #{post.comments_counter}"
    
      expect(post.comments_counter).to eq(1)
    end
  end
end

