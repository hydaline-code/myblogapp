# spec/views/posts/index.html.erb_spec.rb

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  let(:user) { User.create(name: 'Hila', photo_link: 'url', bio: 'bio', posts_counter: 0) }
  let(:post) { user.posts.create(author_id: user.id, text: 'A post', comments_counter: 0, likes_counter: 0) }

  before do
    assign(:user, user)
    assign(:posts, user.posts.paginate(page: 1, per_page: 2))
    render
  end

  it 'displays a list of posts' do
    expect(rendered).to have_selector('.post', count: user.posts.count)

    user.posts.each do |post|
      expect(rendered).to have_selector(".post#post_#{post.id}")
      expect(rendered).to have_content(post.title)
      expect(rendered).to have_content(post.text)
    end
  end

  it 'renders pagination links' do
    expect(rendered).to have_selector('.pagination')
  end
end
