require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Playlist Manager' do
  let(:grove) { create(:grove_with_students) }
  let(:teacher) { create(:teacher, grove: grove) }
  let(:student) { grove.students.first }
  let(:student2) { grove.students.last }
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

    scenario "teacher can search for a specific student" do
      grove_playlist_page.visit_page.search_for(student.name)

      expect(current_path).to eq(admin_grove_playlist_manager_path)
      expect(grove_playlist_page).to have_content(student.name)
      expect(grove_playlist_page).not_to have_content(student2.name)
    end

    scenario "teacher can view playlist for a specific student" do
      grove_playlist_page.visit_page
                         .search_for(student.name)
                         .click_on("View Playlist")

      expect(current_path).to eq(admin_student_playlist_path(student))
      expect(grove_playlist_page).to have_content("#{student.name}'s Grove Playlist")
    end
  end

end
