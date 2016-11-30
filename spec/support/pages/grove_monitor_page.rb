require_relative '../pages/page'
module Pages
  class GroveMonitorPage < Page

    def visit_page
      tap { visit '/admin/grove-monitor-all' }
    end

    def unexpected_students
      page.find_all('div.unexpected div.student h3').map(&:text)
    end
  end

end
