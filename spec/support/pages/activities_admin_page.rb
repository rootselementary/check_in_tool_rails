require_relative '../pages/page'
module Pages
  class ActivityAdminPage < Page

    def visit_page
      visit '/admin/activities'
      self
    end

    def visit_new_activity_page
      visit '/admin/activities/new'
      self
    end

    def visit_activity_page(id)
      visit "/admin/activities/#{id}"
      self
    end

    def visit_edit_activity_page(id)
      visit "/admin/activities/#{id}/edit"
      self
    end

    def edit_activity(name, location, filename = nil)
      fill_in "Title", with: name
      select location.name, from: "Location"
      attach_file "Image", filename if filename
      click_on "Save"
      self
    end

    def create_new_activity(name, location, filename = "#{Rails.root}/spec/support/images/activity.png")
      fill_in "Title", with: name
      select location.name, from: "Location"
      attach_file "Image", filename
      click_on "Save"
    end

    def delete_activity(id)
      delete(:activity, id)
    end
  end
end
