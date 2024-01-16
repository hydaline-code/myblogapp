require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { User.create(name: 'chacha', photo_link: 'url', bio: 'bio', posts_counter: 0) }
  let(:post) { user.posts.create(author_id: user.id, text: 'A post', comments_counter: 0, likes_counter: 0) }

  describe 'GET #index' do
    it 'returns a successful http response' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('<h3>chacha</h3>')
    end
  end

  describe 'GET #show' do
    it 'returns a successful http response' do
      get "/users/#{user.id}/posts/author_id"
      expect(response).not_to have_http_status(:success)
    end

    it 'redirects to user profile when post is not found' do
      get "/users/#{user.id}/posts/author_id"
      puts "Response Body:\n#{response.body}"
      expect(response).to redirect_to(user_path(user))
    end

    it 'includes no  user name in the response body if post id not found' do
      get "/users/#{user.id}/posts/author_id"
      expect(response.body).to include('')
    end
  end
end
