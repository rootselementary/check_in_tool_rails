require_relative '../pages/page'
module Pages
  class LogoutPage < Page
    def visit_page
      visit '/logout'
      self
    end

    def logout
      click_on 'Log out'
    end
  end
end
