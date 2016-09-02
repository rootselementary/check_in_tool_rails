require_relative '../pages/page'
module Pages
  class DashboardPage < Page

    def visit_page
      tap { visit '/admin/dashboard' }
    end
  end
end
