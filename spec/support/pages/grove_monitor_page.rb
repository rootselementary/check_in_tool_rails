require_relative '../pages/page'
module Pages
  class GroveMonitorPage < Page

    def visit_page
      visit '/admin/grove-monitor-all'
      self
    end
  end
end
