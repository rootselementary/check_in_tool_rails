require 'rails_helper'
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
