require 'rails_helper'

class LoginPage
  include Capybara::DSL

  def visit_page
    visit '/'
    self
  end

  def login(user)
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_on 'Log In'
  end
end

RSpec.feature 'Navigating through workpapers' do
  let(:user) { create(:user) }
  let(:login_page) { LoginPage.new }

  scenario "User can login with email and password" do

    login_page.visit_page.login(user)

    expect(response.status).to eq(200)
    expect(current_path).to eq(user_path)
    expect(page).to have_content("Welcome, #{user.name}.")
  end
end
