require_relative '../pages/page'
module Pages
  class ActivityAdminPage < Page

    def visit_page
      visit '/admin/activities'
      self
    end

  end
end
