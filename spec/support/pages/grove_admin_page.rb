module Pages
  class GroveAdminPage < Page
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
