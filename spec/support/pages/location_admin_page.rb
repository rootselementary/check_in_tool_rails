require_relative '../pages/page'
module Pages
  class LocationAdminPage < Page

    def visit_page
      visit '/admin/locations'
      self
    end

    def create_location(grove_name)
      click_on "New Location"
      fill_in "Name", with: "Springfield"
      select grove_name, from: "location[grove_id]"
      click_on "Save"
      page.has_content? "Location Saved"
    end

    def view_location(name)
      view_resource(name)
    end

    def delete_location(id)
      delete(:location, id)
    end

    def update_location_name(name, new_name)
      page.within('tr', text: name) do
        click_on "Edit"
      end
      page.fill_in "Name", with: new_name
      page.click_on "Save"
      page.has_content? "Student Saved"
    end
  end
end
