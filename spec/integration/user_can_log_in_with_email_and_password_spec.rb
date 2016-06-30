require 'rails_helper'

class LoginPage
  include Capybara::DSL

  def visit_page
    visit '/'
    click_on 'Login'
    self
  end

  def login(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Log In'
  end
end

RSpec.feature 'User can login' do
  let(:user) { create(:user) }
  let(:login_page) { LoginPage.new }

  scenario "User can login with email and password" do

    login_page.visit_page.login(user)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_content("Signed in successfully.")
  end
end
