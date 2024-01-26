require 'rails_helper'

RSpec.describe "Post show page", type: :system do
  before(:each) do
    @user = User.create(name: 'Dengo', photo_link: 'url', bio: 'The Best Programmer', posts_counter: 0)
    @post = Post.create(author_id: @user.id, text: 'Read my story with on becoming the best programmer here', title: 'My Journey to become the Best programmer ', comments_counter: 0, likes_counter: 0)
  
  end

  it 'displays  details of a post' do
    visit user_post_path(@user, @post)

    expect(page).to have_content(@user.name)
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.text)
    expect(page).to have_content("comments: #{@post.comments.count}")
    expect(page).to have_content("likes: #{@post.likes.count}")
   
  end

  it 'displays  like creation  for  a post ' do
  visit user_post_path(@user, @post)

  Like.create(user_id: @user.id, post_id: @post.id
  click_button 'Like'

  expect(page).to have_content('Like created successfully')
  expect(page).to have_content("likes: #{@post.likes.count}")
  expect(page).to have_content(@user.name)
end
 it 'displays post comments' do
    comment_user = User.create(name: 'commenter', photo_link: 'commenter_url', bio: 'Commenter bio', posts_counter: 0)
    comment = Comment.create(user_id: comment_user.id, post_id: @post.id, text: 'A comment')

    visit user_post_path(@user, @post)

    expect(page).to have_content(comment_user.name)
    expect(page).to have_content(comment.text)
  end
end
