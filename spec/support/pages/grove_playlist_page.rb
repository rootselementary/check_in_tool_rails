require_relative '../pages/page'
module Pages
  class GrovePlaylistPage < Page

    def visit_page
      visit '/admin/grove-playlist-manager'
      self
    end
  end
end
