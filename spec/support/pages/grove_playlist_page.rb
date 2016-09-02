require_relative '../pages/page'
module Pages
  class GrovePlaylistPage < Page

    def visit_page
      tap { visit '/admin/grove-playlist-manager' }
    end

    def search_for(name)
      tap do |page| 
        fill_in "Search", with: name
        click_on "Search"
      end 
    end

    def view_playlist(name)
      view_resource(name)
    end

    def add_new_activity(activity, focus_area = nil)
      tap do |page|
        click_on "New Activity"
        select activity.title, from: "Activity"
        select focus_area.name, from: "Focus area" if focus_area
        click_on "Create Playlist activity"
      end
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
      select activity.title, from: "Activity"
      if focus_area
        select focus_area.name, from: "Focus area"
      else
        select "none", from: "Focus area"
      end
      click_on "Update Playlist activity"
    end
  end
end
