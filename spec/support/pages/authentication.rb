module Pages
  module Authentication

    def login(user, password="password")
      login_page = Pages::LoginPage.new
      login_page.visit_page.login(user, password)
    end

    def login_with_google(user, password="password")
      login_page = Pages::LoginPage.new
      login_page.visit_google_login
    end

    def logout
      logout_page = Pages::LogoutPage.new
      logout_page.visit_page.logout
    end

  end
end
