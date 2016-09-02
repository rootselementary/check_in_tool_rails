module Pages
  class Page
    include Capybara::DSL

    def view_resource(name)
      tap do |page|
        within("tr", text: name) do
          click_on "View"
        end
      end 
    end

    def delete(resource, id)
      within("##{resource}-#{id}") do
        click_on('Delete')
      end
    end

    def has_image?(image_name)
      src = image_name[0...image_name.index('.')]
      has_xpath?("//img[contains(@src,\"#{src}\")]")
    end
  end
end
