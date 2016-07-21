require_relative '../pages/page'
module Pages
  class StudentAdminPage < Page

    def visit_page
      visit '/admin/students'
      self
    end

    def create_student(grove_name, *roles)
      click_on "New Student"
      fill_in "Name", with: "Bart Simpson"
      fill_in "Email", with: "student@example.com"
      select grove_name, from: "student[grove_id]"
      click_on "Save"
      page.has_content? "Student Saved"
    end

    def view_student(name)
      view_resource(name)
    end

    def delete_student(id)
      delete(:student, id)
    end

    def update_student_name(name, new_name)
      page.within('tr', text: name) do
        click_on "Edit"
      end
      page.fill_in "Name", with: new_name
      page.click_on "Save"
      page.has_content? "Student Saved"
    end
  end
end
