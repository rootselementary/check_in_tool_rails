require_relative '../pages/page'
module Pages
  class LocationAdminPage < Page

    def visit_page
      tap { visit '/admin/locations' }
    end

    def visit_new_location_page
      tap { visit '/admin/locations/new' }
    end

    def visit_location_page(id)
      tap { visit "/admin/locations/#{id}" }
    end

    def visit_edit_location_page(id)
      tap { visit "/admin/locations/#{id}/edit" }
    end

    def create_location(grove_name)
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

    def update_location_name(location, new_name)
      page.fill_in "Name", with: new_name
      page.click_on "Save"
      page.has_content? "Location Saved"
    end

    def update_location_grove(location, new_grove)
      select new_grove, from: "location[grove_id]"
      page.click_on "Save"
      page.has_content? "Location Saved"
    end
  end
end
