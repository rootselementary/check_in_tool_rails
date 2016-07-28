require 'rails_helper'
include Pages::Authentication

RSpec.feature 'User can login' do
  let(:student) { create :student }
  let(:teacher) { create :teacher }

  describe "teacher with valid credentials" do
    scenario "teacher can login with email and password" do
      login(teacher)
      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Hello, #{teacher.first_name}")
      expect(page).to have_content("Grove Configuration")
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
      expect(page).to have_content("Hello, #{student.first_name}")
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

  describe "as a google student within the Roots org" do
    let(:student) { create :student }

    before do
      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: "Google",
        uid: "11111111",
        info: {
          name: student.name,
          email: student.email,
          first_name: "JJ",
          last_name: "Letest",
          image: ""
        },
        credentials: {
          token: "token",
          refresh_token: "another_token",
          expires_at: 1354920555,
          expires: true
        },
        extra: {
          id_token: 1000.times.map { "string" }.join, # this huge chunk is used to test for CookieOverflow exception
          raw_info: OmniAuth::AuthHash.new(
            email: "test@example.com",
            email_verified:"true",
            kind:"plus#personOpenIdConnect",
            name:"Test Person",
          ),
          id_info: {
            hd: "rootselementary.org"
          }
        }
      })
    end

      scenario "Student within Roots org with correct credentials logs in" do
        login_with_google(student)

        expect(current_path).to eq(compass_path)
        expect(page).to have_content("Successfully authenticated from Google account.")
        expect(page).to have_content(student.first_name)
      end

    after do
      OmniAuth.config.test_mode = false
    end
  end

  describe "as a google teacher within the Roots org" do
    let(:teacher) { create :teacher }

    before do
      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: "Google",
        uid: "11111111",
        info: {
          name: teacher.name,
          email: teacher.email,
          first_name: "JJ",
          last_name: "Letest",
          image: ""
        },
        credentials: {
          token: "token",
          refresh_token: "another_token",
          expires_at: 1354920555,
          expires: true
        },
        extra: {
          id_token: 1000.times.map { "string" }.join, # this huge chunk is used to test for CookieOverflow exception
          raw_info: OmniAuth::AuthHash.new(
            email: "test@example.com",
            email_verified:"true",
            kind:"plus#personOpenIdConnect",
            name:"Test Person",
          ),
          id_info: {
            hd: "rootselementary.org"
          }
        }
      })
    end

      scenario "Teacher within Roots org with correct credentials logs in" do
        login_with_google(teacher)

        expect(current_path).to eq(admin_dashboard_path)
        expect(page).to have_content("Successfully authenticated from Google account.")
        expect(page).to have_content(teacher.first_name)
      end

    after do
      OmniAuth.config.test_mode = false
    end
  end

  describe "as a google user outside the domain" do
    let(:teacher) { create :teacher }

    before do
      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: "Google",
        uid: "11111111",
        info: {
          name: "jj_letest",
          email: "letest@gmail.com",
          first_name: "JJ",
          last_name: "Letest",
          image: ""
        },
        credentials: {
          token: "token",
          refresh_token: "another_token",
          expires_at: 1354920555,
          expires: true
        },
        extra: {
          id_token: 1000.times.map { "string" }.join, # this huge chunk is used to test for CookieOverflow exception
          raw_info: OmniAuth::AuthHash.new(
            email: "test@example.com",
            email_verified:"true",
            kind:"plus#personOpenIdConnect",
            name:"Test Person",
          ),
          id_info: {
          }
        }
      })
    end

      scenario "Teacher outside Roots org can not log in" do
        login_with_google(teacher)

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Google account must be within the Roots Elementary Organization.")
        expect(page).to have_content("Sign in with Google")
      end

    after do
      OmniAuth.config.test_mode = false
    end
  end
end
