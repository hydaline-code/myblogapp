require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to a user and a post' do
      user = User.new(name: 'hyda', photo_link: 'url', bio: 'developer')
      user.save
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post1', comments_counter: 0, likes_counter: 0)
      post.save
      like = Like.new(user: user, post: post)
      expect(like.user).to eq(user)
      puts "likes = #{(like.user)}"
      expect(like.post).to eq(post)
      puts "likes = #{(post.likes_counter)}"
    end

    it 'does not increment post.likes_counter if like is not saved' do
      user = User.new(name: 'hyda', photo_link: 'url', bio: 'developer')
      user.save
      post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post1', comments_counter: 0, likes_counter: 0)
      post.save
      like = Like.new(user: user, post: post)
      expect(post.likes_counter).to eq(0)
    end
  end 
  describe 'update_likes_counter method' do
      it 'increments post.likes_counter after saving a like' do
        user = User.new(name: 'hyhha', photo_link: 'url', bio: 'developer', posts_counter: 0)
        user.save
        puts "user = #{user.errors.full_messages}"
        post = Post.new(author_id: user.id, title: 'new title', text: 'This is my second post1', comments_counter: 0, likes_counter: 0)
        post.save
        puts "post = #{post.errors.full_messages}"
        like = Like.new(user: user,post: post)
       
        puts "likes = #{like.errors.full_messages}"

        like.save
        puts "likes (after save) = #{like.errors.full_messages}"
         post.reload
         
        expect(post.likes_counter).to eq(1)
        puts "likes (after save) = #{(post.likes_counter)}"
      end
  end
end

