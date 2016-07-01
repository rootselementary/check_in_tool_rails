module Pages
  module Authentication

    def login(user, password="password")
      login_page = Pages::LoginPage.new
      login_page.visit_page.login(user, password)
    end

  end
end
