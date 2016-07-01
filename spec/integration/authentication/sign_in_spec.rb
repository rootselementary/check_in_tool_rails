require 'rails_helper'
include Pages::Authentication

RSpec.feature 'User can login' do
  let(:role1) { create :role }
  let(:role2) { create :role, name: 'teacher' }

  let(:student) { create :user }
  let(:teacher) { create :user }

  describe "teacher with valid credentials" do
    scenario "teacher can login with email and password" do
      teacher.role = role2
      login(teacher)
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{teacher.email}")
      expect(page).to have_content("Signed in successfully.")
    end
  end

  describe "teacher with invalid credentials" do
    it "provides a kind error message" do
      teacher.role = role2
      login(teacher, "passwordXXX")
      expect(page).to have_content("Invalid Email or password friend.")
    end
  end

  describe "student with valid credentials" do
    scenario "student can login with email and password" do
      student.role = role1
      login(student)
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{student.email}")
      expect(page).to have_content("Signed in successfully.")
    end
  end

  describe "student with invalid credentials" do
    it "provides a kind error message" do
      student.role = role1
      login(student, "passwordXXX")
      expect(page).to have_content("Invalid Email or password friend.")
    end
  end

  describe "as a google user within the Roots org"

  describe "as a google user outside the domain"


end
