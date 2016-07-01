require 'rails_helper'
include Pages::Authentication

RSpec.feature 'User can login' do
  let(:user) { create :user }

  describe "with valid credentials" do
    scenario "User can login with email and password" do
      login(user)
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{user.email}")
      expect(page).to have_content("Signed in successfully.")
    end
  end

  describe "with invalid credentials" do
    it "provides a kind error message" do
      login(user, "passwordXXX")
      expect(page).to have_content("Invalid Email or password friend.")
    end
  end

  describe "as a google user within the Roots org"

  describe "as a google user outside the domain"


end
