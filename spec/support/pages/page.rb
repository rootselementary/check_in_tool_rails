module Pages
  class Page
    include Capybara::DSL

    def view_resource(name)
      within("tr", text: name) do
        click_on "View"
      end
      self
    end

    def delete(resource, id)
      within("##{resource}-#{id}") do
        click_on('Delete')
      end
    end
  end

end
