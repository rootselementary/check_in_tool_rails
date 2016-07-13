require_relative '../pages/page'
module Pages
  class GrovePlaylistPage < Page

    def visit_page
      visit '/admin/grove-playlist-manager'
      self
    end

    def search_for(name)
      fill_in "Search", with: name
      click_on "Search"
    end
  end
end
