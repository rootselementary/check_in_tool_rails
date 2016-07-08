require_relative '../pages/page'
module Pages
  class DashboardPage < Page

    def visit_page
      visit '/admin/dashboard'
      self
    end
  end
end
