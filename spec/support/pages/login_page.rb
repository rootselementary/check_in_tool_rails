require_relative '../pages/page'
module Pages
  class LoginPage < Page

    def visit_page
      tap do |page|
        visit "/?email_login=true"
        click_on 'Login'
      end
    end

    def login(user, password)
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_on 'Log in'
    end

    def visit_google_login
      tap do |page|
        visit '/'
        click_on 'Sign in with Google'
      end
    end
  end
end
