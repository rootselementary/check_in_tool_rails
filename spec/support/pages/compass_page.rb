require_relative '../pages/page'
module Pages
  class CompassPage < Page
    def visit_page
      visit '/compass'
      self
    end
  end
end
