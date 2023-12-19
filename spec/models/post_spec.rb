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
    # it 'comments_counter must be greater than or equal to 0' do
    #   user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
    #   post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post', comments_counter: -1)
    #   expect(post).to_not be_valid
    # end
    # it 'likes_counter must be equal to 0' do
    #   user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
    #   post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post', likes_counter: 1)
    #   expect(post).to_not be_valid
    # end
  end
end
