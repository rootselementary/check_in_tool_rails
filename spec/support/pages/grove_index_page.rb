require_relative '../pages/page'
module Pages
  class GroveIndexPage < Page

    def visit_page
      visit '/admin/groves'
      self
    end

    def go_to_show_page(id)
      visit "/admin/groves/#{id}"
      self
    end

    def delete_grove(id)
      within("#grove-#{id}") do
        click_on('delete')
      end
    end
  end
end
