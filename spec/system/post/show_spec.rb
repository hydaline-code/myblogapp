# spec/system/post/show_spec.rb
require 'rails_helper'

RSpec.describe "Post show page", type: :system do
  before(:each) do
    @user = User.create(name: 'saysha', photo_link: 'url', bio: 'This is bio', posts_counter: 0)
    @post = Post.create(author_id: @user.id, text: 'Her post1', title: 'my title1', comments_counter: 0, likes_counter: 0)
  end

  # it 'displays post details' do
  #   visit user_post_path(@user, @post)

  #   expect(page).to have_content(@post.title)
  #   expect(page).to have_content(@user.name)
  #   expect(page).to have_content("comments: #{post.comments.count}")
  #   expect(page).to have_content("likes: #{post.likes.count}")
  #   expect(page).to have_content(@post.text)
  # end

  # it 'displays post likes' do
  #   liker_user = User.create(name: 'liker', photo_link: 'liker_url', bio: 'Liker bio', posts_counter: 0)
  #   like = Like.create(user_id: liker_user.id, post_id: @post.id)

  #   visit user_post_path(@user, @post)

  #   expect(page).to have_content(liker_user.name)
  #   expect(page).to have_content("likes: #{post.likes.count}")
  # end

  # spec/system/post/show_spec.rb
it 'displays post likes' do
  liker_user = User.create(name: 'chachaqueen', photo_link: 'liker_url', bio: 'Liker bio', posts_counter: 0)

  Like.create(user_id: liker_user.id, post_id: @post.id)

  visit user_post_path(@user, @post)

  click_button 'Like'

  expect(page).to have_content('Like created successfully')

  expect(page).to have_content(@user.name)
  expect(page).to have_content("Likes: 1") 
end


  it 'displays post comments' do
    # Assuming you have comments associated with the post
    comment_user = User.create(name: 'commenter', photo_link: 'commenter_url', bio: 'Commenter bio', posts_counter: 0)
    comment = Comment.create(user_id: comment_user.id, post_id: @post.id, text: 'A comment')

    visit user_post_path(@user, @post)

    expect(page).to have_content(comment_user.name)
    expect(page).to have_content(comment.text)
  end
end
