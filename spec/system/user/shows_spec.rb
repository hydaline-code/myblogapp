require 'rails_helper'

RSpec.describe "Shows", type: :system do
  before(:each) do
   @user = User.create(name: 'ila', photo_link: 'url', bio: 'This is bio', posts_counter: 0)
    @post1 = Post.create(author_id: @user.id, text: 'A post1',  title: 'new title1',  comments_counter: 0, likes_counter: 0)
   @post2 = Post.create(author_id: @user.id, text: 'A post2',  title: 'new title2', comments_counter: 0, likes_counter: 0)
  @post3 = Post.create(author_id: @user.id, text: 'A post3',  title: 'new title3', comments_counter: 0, likes_counter: 0)

  end

  it 'displays user information and first 3 posts' do
    visit user_path(@user)

    expect(page).to have_selector("img[src*='url']") 
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Number of posts: 3") 
    expect(page).to have_content(@user.bio)

    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)

    expect(page).to have_button('See all posts')
  end
  sleep(10)
end
