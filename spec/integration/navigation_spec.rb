require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Navigation options' do
  let(:student) { create :student }
  let(:teacher) { create :teacher }

  describe "logged in teacher" do
    it "sees navigation bar with grove monitor and playlist options" do
      login(teacher)

      expect(page).to have_content("Welcome, #{teacher.email}")
      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_content("Grove Monitor")
      expect(page).to have_content("Grove Playlist")
    end
  end

  describe "logged in student" do
    it "does not a display a nav bar" do
      login(student)

      expect(page).not_to have_content("Grove Monitor")
      expect(page).not_to have_content("Grove Playlist")
    end
  end

  describe "guest user" do
    it "does not a display a nav bar" do
      visit '/'

      expect(page).not_to have_content("Grove Monitor")
      expect(page).not_to have_content("Grove Playlist")
    end
  end

end
