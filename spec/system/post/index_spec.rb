# spec/system/user/user_posts_spec.rb
require 'rails_helper'

RSpec.describe "User post index page", type: :system do
  before(:each) do
    @user = User.create(name: 'sasha', photo_link: 'url', bio: 'This is bio', posts_counter: 0)
    @post = Post.create(author_id: @user.id, text: 'A post1', title: 'new title1', comments_counter: 0, likes_counter: 0)
    @post = Post.create(author_id: @user.id, text: 'A post2', title: 'new title2', comments_counter: 0, likes_counter: 0)
    # @post = Post.create(author_id: @user.id, text: 'A post3', title: 'new title3', comments_counter: 0, likes_counter: 0)
    # @post = Post.create(author_id: @user.id, text: 'A post4', title: 'new title4', comments_counter: 0, likes_counter: 0)
    # Create more posts as needed for pagination testing
  end

  it 'displays user profile and post information' do
    visit user_posts_path(@user)

    expect(page).to have_selector("img[src*='url']") 
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
  end 
  it 'displays the  post information' do
    visit user_posts_path(@user)

     expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.text) 
    expect(page).to have_content("comments: #{ @post.comments.count}")
    expect(page).to have_content("likes: #{@post.likes.count}")
    # sleep(5)
    # expect(page).to have_class('.pagination')
  
  end 
    # @posts.each do |post|
    #   expect(page).to have_content(post.title)
    #   expect(page).to have_content(post.text)
    #   expect(page).to have_content("Comments: #{post.comments_counter}")
    #   expect(page).to have_content("Likes: #{post.likes_counter}")
    # end

    # expect(page).to have_content(@post2.title)
    # expect(page).to have_content(@post2.text) 
    # expect(page).to have_content("Comments: #{ @post3.comments.count}")
    # expect(page).to have_content("Likes: #{@post3.likes.counter}")

  

  it 'redirects to post show page when clicking on a post' do
    visit user_posts_path(@user)

    # Click the link of the first post
    click_link "Post #{@post.id}"
    sleep(5)

    # Ensure it redirects to the post show page
    expect(current_path).to eq(user_post_path(@user, @post))
  end
end
