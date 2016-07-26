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
      location2 = create(:location, grove: grove2)
      create(:activity, name: "Reading outloud", location: location2, grove: grove2)
      activity_admin_page.visit_page

      expect(activity_admin_page).to have_content("Playing with numbers")
      expect(activity_admin_page).not_to have_content("Reading outloud")
    end

    it 'allows a teacher to delete an activity' do
      activity_admin_page.visit_page

      expect(activity_admin_page).to have_content(activity.name)
      activity_admin_page.delete_activity(activity.id)
      expect(activity_admin_page.visit_page).not_to have_content(activity.name)
    end

    it 'allows a teacher to create an activity' do
      activity_admin_page.visit_new_activity_page
      expect {
        activity_admin_page.create_new_activity("Reading time", location)
      }.to change {
        Activity.where(grove_id: teacher.grove_id).count
      }.by 1
    end

    it 'allows a teacher to edit an activity' do
      location2 = create(:location, name: "New Location", grove: grove)
      expect {
        activity_admin_page.visit_edit_activity_page(activity.id)
                         .edit_activity("Reading time", location2)
      }.not_to change {
        Activity.where(grove_id: teacher.grove_id).count
      }
      activity_admin_page.visit_page
      expect(activity_admin_page).to have_content "Reading time"
      expect(activity_admin_page).not_to have_content activity.name
      expect(activity_admin_page).to have_content "New Location"
      expect(activity_admin_page).not_to have_content location.name
    end

    describe 'viewing individual activity' do
      it 'displays the activity properties' do
        activity_admin_page.visit_activity_page(activity.id)
        expect(activity_admin_page).to have_content activity.name
        expect(activity_admin_page).to have_content location.name
        expect(activity_admin_page).to have_image "activity-default.png"
      end
    end
  end
end
