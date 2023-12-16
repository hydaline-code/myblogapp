require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'name must be exist' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      user.name = nil
      expect(user).to_not be_valid
    end
    it 'posts_counter must be greate that 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: -1)
      expect(user).to_not be_valid
    end
    it 'posts_counter must be greate that 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 0)
      expect(user).to be_valid
    end
    it 'posts_counter must be greate that 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 1)
      expect(user).to be_valid
    end
    it 'most_recent_posts should return last 3 post' do
      user = User.create(name: 'chacha', photo_link: 'url', bio: 'developer')
      Post.create(author_id: user.id, title: 'new title', text: 'This is my second post')
      post1 = Post.create(author_id: user.id, title: 'new title1', text: 'This is my second post')
      post2 = Post.create(author_id: user.id, title: 'new title2', text: 'This is my second post')
      post3 = Post.create(author_id: user.id, title: 'new title3', text: 'This is my second post')
      most_recent_posts = user.most_recent_posts
      expect(most_recent_posts).to eq([post1, post2, post3])
    end
  end
end
