require_relative '../pages/page'
module Pages
  class CompassPage < Page
    def visit_page
      tap { visit '/compass' }
    end
  end
end
