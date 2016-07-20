require_relative '../pages/page'
module Pages
  class TeacherAdminPage < Page

    def visit_page
      visit '/admin/teachers'
      self
    end

    def create_teacher(grove_name, *roles)
      click_on "New Teacher"
      fill_in "Name", with: "Bart Simpson"
      fill_in "Email", with: "teacher@example.com"
      select grove_name, from: "teacher[grove_id]"
      roles.each do |role|
        check role.to_s.downcase
      end
      click_on "Save"
      page.has_content? "Teacher Saved"
    end

    def view_teacher(name)
      view_resource(name)
    end

    def delete_teacher(id)
      delete(:teacher, id)
    end

    def update_teacher_name(name, new_name)
      page.within('tr', text: name) do
        click_on "Edit"
      end
      page.fill_in "Name", with: new_name
      page.click_on "Save"
      page.has_content? "Teacher Saved"
    end
  end
end
