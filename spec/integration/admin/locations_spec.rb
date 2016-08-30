require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Managing Locations' do
  let(:school) { create(:school) }
  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:location_admin_page) { Pages::LocationAdminPage.new }

  describe 'as a teacher with an administrative role' do
    let(:administrator) { create(:teacher, :admin, school: school, grove: grove) }
    let!(:location) { create(:location, name: "Shelbyville", grove: grove) }
    let!(:grove) { create(:grove, school: school) }
    let!(:new_grove) { create(:grove, school: school)}

    before { login(administrator) }

    it 'provides a link to manage locations' do
      expect(dashboard_page).to have_content("Locations")
    end

    it 'shows the locations' do
      location_admin_page.visit_page
      expect(location_admin_page).to have_content("Shelbyville")
    end

    describe 'creating a new location' do
      it 'allows creation of a new location' do
        location_admin_page.visit_new_location_page
        expect {
          location_admin_page.create_location(grove.name)
        }.to change { Grove.find(grove.id).locations.count }.by(1)
      end
    end

    describe 'updating a location' do
      it 'updates the location name' do
        location_admin_page.visit_edit_location_page(location.id)
        expect {
          location_admin_page.update_location_name(location, "Springfield")
        }.to change {
          Location.where(name: "springfield").count
        }.from(0).to(1)
      end

      it 'updates the location grove' do
        location_admin_page.visit_edit_location_page(location.id)
        expect {
          location_admin_page.update_location_grove(location, new_grove.name)
        }.to change {
          Location.where(grove: new_grove.id).count
        }.from(0).to(1)
      end
    end

    describe 'viewing a location' do
      it 'views an individual location' do
        location_admin_page.visit_location_page(location.id)
        expect(page).to have_content("Shelbyville")
      end
    end

    describe 'deleting a location' do
      it 'allows user to delete a location' do
        location_admin_page.visit_page
        expect(location_admin_page).to have_content(location.titleized_name)
        location_admin_page.view_location(location.titleized_name).delete_location(location.id)
        expect(location_admin_page.visit_page).to_not have_content(location.name)
      end
    end

  end

end
