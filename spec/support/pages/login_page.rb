require_relative '../pages/page'
module Pages
  class LoginPage < Page

    def visit_page
      visit "/"
      click_on 'Login'
      self
    end

    def login(user, password)
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_on 'Log in'
    end

    def visit_google_login
      visit '/'
      click_on 'Sign in with Google'
      self
    end
  end
end
