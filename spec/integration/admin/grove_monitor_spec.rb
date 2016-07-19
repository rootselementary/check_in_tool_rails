require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Monitor' do
  let(:teacher) { create(:teacher) }
  let(:dashboard_page) { Pages::DashboardPage.new }

  describe 'as a teacher' do
    before { login(teacher) }

    it 'can be reached from the main dashboard' do
      dashboard_page.click_on("Grove Monitor")
      expect(current_path).to eq(admin_grove_monitor_path)
    end

# PlaylistItem => Name, Location, Duration, timestamps, type
# ScheduledActivity => polymorphic on playlistitem
# FlexTimeActivity => polymorphic on playlistitem
# HomeStationActivity => polymorphic on playlistitem
# Activity => User(Id), FlextimeItem(Id), timestamps, CheckInTime, PlaylistItem(Id), PlaylistItem(Type)
# give me the activities for a student within the last hour
# Activity.playground #=> give me all the activities from the last hour where the last of those activities is a playground type
# School master_calendar => [900, 945, 1015]
    it 'shows all lost student' do
      dashboard_page.click_on("Grove Monitor")
      click_on("Lost")
      expect(page).to have_content(lost_student.name)
      # a lost student is a student who has checked into an activity at some point in the day but has not checked into an activity/event after expected time lapse.
    end
  end

end
