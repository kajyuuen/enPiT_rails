require 'rails_helper'

describe 'view home page', type: :feature do
  scenario do
    visit static_pages_home_url
    expect(page).to have_title 'Ruby on Rails Tutorial Sample App'
  end
end

describe 'view help page', type: :feature do
  scenario do
    visit static_pages_help_url
    expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'
  end
end

describe 'view about page', type: :feature do
  scenario do
    visit static_pages_about_url
    expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'
  end
end
