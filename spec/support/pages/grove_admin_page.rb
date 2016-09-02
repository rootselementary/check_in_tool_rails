require_relative '../pages/page'
module Pages
  class GroveAdminPage < Page

    def visit_page
      tap { visit '/admin/groves' }
    end

    def view_grove(name)
      view_resource(name)
    end

    def go_to_show_page(id)
      tap { visit "/admin/groves/#{id}" }
    end

    def delete_grove(id)
      delete(:grove, id)
    end

    def create_new_grove(name="Ponderosa")
      page.has_content? "Create A New Grove"
      page.fill_in "Name", with: name
      page.click_on "Save"
      page.has_content? "Grove Saved"
    end

    def update_grove_name(name, new_name)
      page.within('tr', text: name) do
        click_on "Edit"
      end
      page.fill_in "Name", with: new_name
      page.click_on "Save"
      page.has_content? "Grove Saved"
    end
  end
end
