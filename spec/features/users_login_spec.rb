require 'rails_helper'

describe 'User login' do

  before { visit login_path }
  let(:submit) { 'Log in' }

  describe 'login with invalid information' do
    before do
      fill_in 'session[email]', with: ''
      fill_in 'session[password]', with: ''
    end
    it 'should invalid information' do
      click_button submit
      expect(page).to have_content('Invalid email/password combination')
      visit current_path
      expect(page).to_not have_content('Invalid email/password combination')
    end
  end

  describe 'login with valid information' do
    it 'should valid information' do
      user = create(:user)

      visit login_path
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_button submit

      expect(current_path).to eq(user_path(user))
    end
  end

  describe 'login with valid information followed by logout' do
    it 'should be logout' do
      user = create(:user)

      visit login_path
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_button submit

      expect(current_path).to eq(user_path(user))
      click_on('Log out')
      expect(current_path).to eq(root_path)
    end
  end
end
