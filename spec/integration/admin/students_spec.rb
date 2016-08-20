require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Managing Students' do
  let(:school) { create(:school) }
  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:student_admin_page) { Pages::StudentAdminPage.new }

  describe 'as a teacher with an administrative role' do
    let(:administrator) { create(:teacher, :admin, school: school, grove: grove) }
    let!(:student) { create(:student, name: "Lisa Simpson", school: school, grove: grove) }
    let!(:grove) { create(:grove, school: school) }
    let!(:role) { create(:role) }

    before { login(administrator) }

    it 'provides a link to manage the students' do
      expect(dashboard_page).to have_content("Students")
    end

    it 'shows the students in the school' do
      dashboard_page.click_on("Students")
      expect(student_admin_page).to have_content("Lisa Simpson")
    end

    describe 'creating a new student' do
      it 'allows creation of a new student' do
        expect {
          dashboard_page.click_on "Students"
          student_admin_page.create_student(grove.name)
        }.to change { Grove.find(grove.id).students.count }.by(1)
      end
    end

    describe 'updating a student' do
      it 'updates the student attributes' do
        dashboard_page.click_on("Students")
        expect {
          student_admin_page.update_student_name(student.name, "Maggie Simpson")
        }.to change {
          Student.where(name: "Maggie Simpson").count
        }.from(0).to(1)
      end
    end

    describe 'viewing a student' do
      it 'views an individual student' do
        dashboard_page.click_on("Students")
        dashboard_page.click_on("View")
        expect(page).to have_content("Lisa Simpson")
      end
    end

    describe 'deleting a student' do
      it 'allows user to delete a student' do
        dashboard_page.click_on "Students"
        expect(student_admin_page).to have_content(student.name)
        student_admin_page.view_student(student.name).delete_student(student.id)
        expect(student_admin_page.visit_page).to_not have_content(student.name)
      end
    end

  end

  describe 'as a teacher without an administrative role' do
    let(:teacher) { create(:teacher, school: school) }

    before { login(teacher) }

    it 'does not allow access' do
      expect { dashboard_page.visit('/admin/students') }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
