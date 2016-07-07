module Pages
  class GroveAdminPage < Page
    def create_new_grove(name="Ponderosa")
      page.has_content? "Create A New Grove"
      page.fill_in 'grove[name]', with: name
      page.click_on "Save"
      page.has_content? "Grove Saved"
    end
  end
end
