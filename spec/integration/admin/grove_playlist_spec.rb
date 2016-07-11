require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Playlist Manager' do
  let(:teacher) { create(:teacher) }
  let(:dashboard_page) { Pages::DashboardPage.new }

  describe 'as a teacher' do
    before { login(teacher) }

    it 'can be reached from the main dashboard' do
      dashboard_page.click_on("Grove Playlist Manager")
      expect(current_path).to eq(admin_grove_playlist_path)
    end
  end

end
