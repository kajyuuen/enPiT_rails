require 'rails_helper'

describe 'User pages' do

  subject { page }
  before { visit signup_path }
  let(:submit) { 'Create my account' }

  it 'should not create an invalid user' do
    expect(current_path).to eq signup_path
  end

  describe 'valid signup information' do
    before do
      fill_in 'user[name]', with: 'Example User'
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end
    it 'should create a user' do
      expect { click_button submit }.to change(User, :count).by(1)
      expect(current_path).to eq user_path(1)
    end
  end
end
