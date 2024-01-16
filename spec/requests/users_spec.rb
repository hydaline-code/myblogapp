require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { User.create(name: 'chacha', photo_link: 'url', bio: 'bio', posts_counter: 0) }

  describe 'GET #index' do
    it 'returns a sucessful http response' do
      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'renders the index template' do
      get '/users'
      expect(response.body).to include('<h1>Users</h1>')
    end
  end

  describe 'GET #show' do
    it 'returns a successful http response' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}"
      expect(response.body).to include('<p>Bio: bio</p>')
    end
  end
end
