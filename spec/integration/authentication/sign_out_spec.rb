require 'rails_helper'
include Pages::Authentication

RSpec.feature 'User can logout' do
  let(:user) { create :user }

  describe "can do so successfully" do
    scenario "logged in user can logout" do
      login(user)
      expect(current_path).to eq(root_path)
      click_on 'Log out'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Signed out successfully.')
    end
  end
end
