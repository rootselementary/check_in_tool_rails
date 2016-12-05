require_relative '../pages/page'
module Pages
  class GroveMonitorPage < Page

    def visit_page
      tap { visit '/admin/grove-monitor-all' }
    end

    def students(*args)
      selectors = args + ['div.student h3']
      page.find_all(selectors.join(' ')).map(&:text)
    end

    def unexpected_students
      students('div.unexpected')
    end

    def lost_students
      page.find_all('div.student h3').map(&:text)
    end
  end

end
