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
      self
    end

    def delete_activity(playlist_activity)
      within("#playlist-activity-#{playlist_activity.id}") do
        click_on("delete-#{playlist_activity.id}")
      end
    end

    def edit_activity(playlist_activity, activity, focus_area = nil)
      within("#playlist-activity-#{playlist_activity.id}") do
        click_on("edit-#{playlist_activity.id}")
      end
      select activity.name, from: "Activity"
      if focus_area
        select focus_area.name, from: "Focus area"
      else
        select "none", from: "Focus area"
      end
      click_on "Update Playlist activity"
    end
  end
end
