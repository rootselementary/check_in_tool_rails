require 'rails_helper'
include Pages::Authentication

RSpec.feature 'User can logout' do
  let(:user) { create :student }

  describe "can do so successfully" do
    scenario "logged in user can logout" do
      login(user)
      expect(current_path).to eq(compass_path)

      visit '/users/logout'
      click_on 'Log out'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Signed out successfully.')
    end
  end
end
