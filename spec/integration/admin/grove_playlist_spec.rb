require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Playlist Manager' do
  let(:grove) { create(:grove) }
  let(:teacher) { create(:teacher, grove: grove) }
  let(:student) { grove.students << create(:student) }
  let(:student2) { grove.students << create(:student) }
  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:grove_playlist_page) { Pages::GrovePlaylistPage.new }

  describe 'as a teacher' do
    before { login(teacher) }

    it 'can be reached from the main dashboard' do
      dashboard_page.click_on("Grove Playlist Manager")
      expect(current_path).to eq(admin_grove_playlist_manager_path)
    end

    scenario "shows all students in teacher grove by default" do
      grove_playlist_page.visit_page
      expect(grove_playlist_page).to have_content(student.name)
      expect(grove_playlist_page).to have_content(student2.name)
    end
  end
end
