require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Managing Activities' do
  let(:grove) { create(:grove) }
  let(:teacher) { create(:teacher, grove: grove) }
  let(:location) { create(:location, grove: grove) }
  let(:activity) { create(:activity, name: "Playing with numbers", location: location, grove: grove)}
  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:activity_admin_page) { Pages::ActivityAdminPage.new }

  describe 'as a teacher' do
    before do
      login(teacher)
      activity
    end

    it 'provides a link to manage the groves' do
      expect(dashboard_page).to have_content("Manage Activities")
    end

    it "shows only activities in the teacher's grove" do
      grove2 = create(:grove)
      create(:activity, name: "Reading outloud", grove: grove2)
      activity_admin_page.visit_page

      expect(activity_admin_page).to have_content("Playing with numbers")
      expect(activity_admin_page).not_to have_content("Reading outloud")
    end

    xit 'allows a teacher to delete an activity' do
      activity_admin_page.visit_page

      expect(grove_admin_page).to have_content(grove.name)
      grove_admin_page.view_grove(grove.name).delete_grove(grove.id)
      expect(grove_admin_page.visit_page).to_not have_content(grove.name)
    end
  end
end
