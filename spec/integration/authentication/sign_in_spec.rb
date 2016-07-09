require 'rails_helper'
include Pages::Authentication

RSpec.feature 'User can login' do
  let(:student) { create :student }
  let(:teacher) { create :teacher }

  describe "teacher with valid credentials" do
    scenario "teacher can login with email and password" do
      login(teacher)
      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Welcome, #{teacher.email}")
      expect(page).to have_content("Teacher Dashboard")
      expect(page).to have_content("Signed in successfully.")
    end
  end

  describe "teacher with invalid credentials" do
    it "provides a kind error message" do
      login(teacher, "passwordXXX")
      expect(page).to have_content("Invalid Email or password friend.")
    end
  end

  describe "student with valid credentials" do
    scenario "student can login with email and password" do
      login(student)
      expect(current_path).to eq(compass_path)
      expect(page).to have_content("Welcome, #{student.email}")
      expect(page).to have_content("Grove Compass")
      expect(page).to have_content("Signed in successfully.")
    end
  end

  describe "student with invalid credentials" do
    it "provides a kind error message" do
      login(student, "passwordXXX")
      expect(page).to have_content("Invalid Email or password friend.")
    end
  end

end
