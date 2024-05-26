require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }

    it 'is valid with valid attributes' do
      blog_post = build(:blog_post, user: user)
      expect(blog_post).to be_valid
    end

    it 'is not valid without a user' do
      blog_post = build(:blog_post, user: nil)
      expect(blog_post).not_to be_valid
    end
  end
end
