require_relative '../pages/page'
module Pages
  class GroveMonitorPage < Page

    def visit_page
      tap { visit '/admin/grove-monitor-all' }
    end
  end
end
