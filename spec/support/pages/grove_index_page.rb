require_relative '../pages/page'
module Pages
  class GroveIndexPage < Page

    def visit_page
      visit '/admin/groves'
      self
    end
  end
end
