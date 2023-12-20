require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'name must be exist' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      user.name = nil
      expect(user).to_not be_valid
    end
    it 'posts_counter must be greater than 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: -1)
      expect(user).to_not be_valid
    end
    it 'posts_counter must be greater than or equal to  0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 0)
      expect(user).to be_valid
    end
    it 'posts_counter must be greater than 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 1)
      expect(user).to be_valid
    end
  end
  describe '#most_recent_posts' do
it 'returns the  most recent 3 posts' do
  user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 0)
  user.save
  post1 = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post1',comments_counter: 0, likes_counter: 0)
   post1.save

 
  post2 = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post2',comments_counter: 0, likes_counter: 0)
   post2.save
  

  post3 = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post3',comments_counter: 0, likes_counter: 0)
   post3.save
  

  expect(user.most_recent_posts).to eq([post3, post2, post1])
end
end
end