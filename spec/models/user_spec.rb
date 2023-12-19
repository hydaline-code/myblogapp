require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'name must be exist' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer')
      user.name = nil
      expect(user).to_not be_valid
    end
    it 'posts_counter must be greater than 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: -1)
      expect(user).to_not be_valid
    end
    it 'posts_counter must be greater than or equal to  0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 0)
      expect(user).to be_valid
    end
    it 'posts_counter must be greater than 0' do
      user = User.new(name: 'shahadat', photo_link: 'url', bio: 'developer', posts_counter: 1)
      expect(user).to be_valid
    end
end
end