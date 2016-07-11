require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Monitor' do
  let(:teacher) { create(:teacher) }
  let(:grove_monitor_page) { Pages::GroveMonitorPage.new }
  let(:dashboard_page) { Pages::DashboardPage.new }

  describe 'as a teacher' do
    before { login(teacher) }

    it 'can be reached from the main dashboard' do
      dashboard_page.click_on("Grove Monitor")
      expect(current_path).to eq(admin_grove_monitor_path)
    end

    it 'provides navigation links' do
      expect(grove_monitor_page).to have_content("Teacher Dashboard")
      expect(grove_monitor_page).to have_content("Grove Monitor")
      expect(grove_monitor_page).to have_content("Grove Playlist Manager")
    end
  end

end
