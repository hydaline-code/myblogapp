require 'rails_helper'

RSpec.describe "Index", type: :system do
  before(:each) do
    @user = User.create(name: 'chacha', photo_link: 'url', bio: 'bio', posts_counter: 0)
    @user1 = User.create(name: 'hyda', photo_link: 'url', bio: 'bio', posts_counter: 0)
  end

  it 'displays usernames, profile pictures, and post counts for all users' do
    visit users_path

    within('.user-card:first-child') do
      expect(page).to have_content(@user.name)
      expect(page).to have_selector("img[src*='#{@user.photo_link}']")
      expect(page).to have_content("Number of posts: #{@user.posts_counter}")
    end
    within('.user-card:nth-child(2)') do
      expect(page).to have_content(@user1.name)
      expect(page).to have_selector("img[src*='#{@user1.photo_link}']")
      expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    end
  end
  it 'clicks on a user and navigates to their profile page' do
    visit users_path

    within('.user-card:first-child') do
      click_link @user.name
    end

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.bio)
    # Add more expectations for the user's profile page
  end
  sleep(10)
end
