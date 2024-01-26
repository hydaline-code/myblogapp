# spec/system/user/user_posts_spec.rb
require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  before(:each) do
    @user = User.create(name: 'sasha', photo_link: 'url', bio: 'This is bio', posts_counter: 0)
    @post1 = Post.create(author_id: @user.id, text: 'A post1', title: 'new title1', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author_id: @user.id, text: 'A post2', title: 'new title2', comments_counter: 0,
                         likes_counter: 0)
  end

  it 'displays user profile and post information' do
    visit user_posts_path(@user)

    expect(page).to have_selector("img[src*='url']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
  end

  it 'displays the  post information' do
    visit user_posts_path(@user)

    @user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content("comments: #{post.comments.count}")
      expect(page).to have_content("likes: #{post.likes.count}")
    end
  end
  it 'displays the  pagination  information' do
    post3 = Post.create(author_id: @user.id, text: 'A post3', title: 'new title4', comments_counter: 0,
                        likes_counter: 0)
    post4 = Post.create(author_id: @user.id, text: 'A post4', title: 'new title3', comments_counter: 0,
                        likes_counter: 0)
    @user.reload

    visit user_posts_path(@user)
    click_link 'Next →'
    sleep(5)
    expect(page).to have_content(post3.title)
    expect(page).to have_content(post4.title)
  end

  it 'redirects to post show page when clicking on a post' do
    visit user_posts_path(@user)

    click_link "Post #{@post1.id}"
    sleep(5)

    expect(current_path).to eq(user_post_path(@user, @post1))
  end
end
