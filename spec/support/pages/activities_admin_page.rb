require_relative '../pages/page'
module Pages
  class ActivityAdminPage < Page

    def visit_page
      tap { visit '/admin/activities' }
    end

    def visit_new_activity_page
      tap { visit '/admin/activities/new' }
    end

    def visit_activity_page(id)
      tap { visit "/admin/activities/#{id}" }
    end

    def visit_edit_activity_page(id)
      tap { visit "/admin/activities/#{id}/edit" }
    end

    def edit_activity(name, location, filename = nil)
      tap do |page|
        fill_in "Title", with: name
        select location.name, from: "Location"
        attach_file "Image", filename if filename
        click_on "Save"
      end 
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
