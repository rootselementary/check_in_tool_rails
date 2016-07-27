require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Managing Locations' do
  let(:school) { create(:school) }
  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:location_admin_page) { Pages::LocationAdminPage.new }

  describe 'as a teacher with an administrative role' do
    let(:administrator) { create(:teacher, :admin, school: school, grove: grove) }
    let!(:location) { create(:location, grove: grove) }
    let!(:grove) { create(:grove, school: school)}
    let!(:role) { create(:role)}

    before { login(administrator) }

    it 'provides a link to manage locations' do
      expect(dashboard_page).to have_content("Manage Locations")
    end

    xit 'shows the students in the school' do
      dashboard_page.click_on("Manage Locations")
      expect(location_admin_page).to have_content("Lisa Simpson")
    end

    describe 'creating a new location' do
      it 'allows creation of a new location' do
        expect {
          dashboard_page.click_on "Manage Locations"
          location_admin_page.create_location(grove.name)
        }.to change { Grove.find(grove.id).locations.count }.by(1)
      end
    end

    describe 'updating a location' do
      xit 'updates the location attributes' do
        dashboard_page.click_on("Manage Locations")
        expect {
          location_admin_page.update_location_name(location.name, "Maggie Simpson")
        }.to change {
          Student.where(name: "Maggie Simpson").count
        }.from(0).to(1)
      end
    end

    describe 'viewing a location' do
      xit 'views an individual location' do
        dashboard_page.click_on("Manage Locations")
        dashboard_page.click_on("View")
        expect(page).to have_content("Lisa Simpson")
      end
    end

    describe 'deleting a location' do
      it 'allows user to delete a location' do
        dashboard_page.click_on "Manage Locations"
        expect(location_admin_page).to have_content(location.name)
        location_admin_page.view_location(location.name).delete_location(location.id)
        expect(location_admin_page.visit_page).to_not have_content(location.name)
      end
    end

  end

  describe 'as a teacher without an administrative role' do
    let(:teacher) { create(:teacher, school: school) }

    before { login(teacher) }

    xit 'does not allow access' do
      expect { dashboard_page.visit('/admin/locations') }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

end
