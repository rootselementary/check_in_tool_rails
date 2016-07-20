require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Managing Teachers' do
  let(:school) { create(:school) }
  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:teacher_admin_page) { Pages::TeacherAdminPage.new }


  describe 'as a teacher with an administrative role' do
    let(:administrator) { create(:teacher, :admin, school: school, grove: grove) }
    let!(:teacher) { create(:teacher, name: "Homer Simpson", school: school, grove: grove) }
    let!(:grove) { create(:grove, school: school)}
    let!(:role) { create(:role)}

    before { login(administrator) }

    it 'provides a link to manage the groves' do
      expect(dashboard_page).to have_content("Manage Teachers")
    end

    it 'shows the teachers in the school' do
      dashboard_page.click_on("Manage Teachers")
      expect(teacher_admin_page).to have_content("Homer Simpson")
    end

    it 'does not show teachers in other schools' do
      other_teacher = create(:teacher, name: "Marge Simpson", school: create(:school))
      dashboard_page.click_on("Manage Teachers")
      expect(teacher_admin_page).to_not have_content("Marge Simpson")
    end

    it 'allows user to delete a teacher' do
      dashboard_page.click_on "Manage Teachers"
      expect(teacher_admin_page).to have_content(teacher.name)
      teacher_admin_page.view_teacher(teacher.name).delete_teacher(teacher.id)
      expect(teacher_admin_page.visit_page).to_not have_content(teacher.name)
    end

    describe 'creating a new teacher' do

      it 'allows creation of a new teacher' do
        expect {
          dashboard_page.click_on "Manage Teachers"
          teacher_admin_page.create_teacher(grove.name)
        }.to change { Grove.find(grove.id).teachers.count }.by(1)
      end

      it 'allows creation of a new admin teacher' do
        expect { dashboard_page.click_on "Manage Teachers"
          teacher_admin_page.create_teacher(grove.name, :admin)
        }.to change { Role.find_by_name("admin").users.count }.by(1)
      end

      it 'ensures teacher is not admin by default' do
        expect { dashboard_page.click_on "Manage Teachers"
          teacher_admin_page.create_teacher(grove.name)
        }.not_to change { Role.find_by_name("admin").users.count }
      end

    end

    describe 'updating a teacher' do
      it 'updates the teacher attributes' do
        dashboard_page.click_on("Manage Teachers")
        expect {
          teacher_admin_page.update_teacher_name(teacher.name, "Lisa Simpson")
        }.to change {
          Teacher.where(name: "Lisa Simpson").count
        }.from(0).to(1)
      end

    end

  end

  describe 'as a teacher without an administrative role' do
    let(:teacher) { create(:teacher) }

    before { login(teacher) }

    it 'does not show the link' do
      expect(dashboard_page).to_not have_content("Manage Teachers")
    end

    it 'does not allow access' do
      expect { dashboard_page.visit('/admin/groves') }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

end
