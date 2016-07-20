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
      self
    end

    def view_playlist(name)
      view_resource(name)
    end

    def add_new_activity(activity, focus_area = nil)
      click_on "New Activity"
      select activity.name, from: "Activity"
      select focus_area.name, from: "Focus area" if focus_area
      click_on "Create Playlist activity"
    end
  end
end
