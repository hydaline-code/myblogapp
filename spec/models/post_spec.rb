require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'title must exit' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post')
      post.title = nil
      expect(post).to_not be_valid
    end
    it 'length must be less than 250' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post')
      post.text = nil
      expect(post).to_not be_valid
    end
    it 'length must  not be 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      post = Post.new(author_id: user.id, title: 'new title')
      expect(post).to_not be_valid
    end
    it 'comments_counter must be greater than or equal to 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post', comments_counter: 1)
      expect(post).to_not be_valid
    end
    it 'likes_counter must be equal to 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post', likes_counter: 1)
      expect(post).to_not be_valid
    end
  end 
  describe '#update_likes_count' do
  it 'updates likes_counter based on the number of likes' do
    user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 0)
    user.save
    post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post',comments_counter: 0, likes_counter: 0)
    post.save
   like=Like.new(user: user, post: post)
   
    like.save
    post.reload
    expect(post.likes_counter).to eq(1)
  end
end

describe '#recent_comments' do
it 'returns the most recent 5 comments' do
  user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 0)
  user.save
  post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post',comments_counter: 0, likes_counter: 0)
  post.save

  comment1 = Comment.new(user: user, post: post, text: 'Comment 1')
  comment1.save

  expect(post.recent_comments).to eq([comment1])
end
end
  end
