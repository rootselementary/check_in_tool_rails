require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Playlist Manager' do
  let(:grove) { create(:grove_with_students) }
  let(:grove2) { create(:grove) }
  let(:teacher) { create(:teacher, grove: grove) }
  let(:teacher2) { create(:teacher, grove: grove2) }
  let(:student) { grove.students.first }
  let(:student2) { grove.students.last }
  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:grove_playlist_page) { Pages::GrovePlaylistPage.new }

  describe 'as a teacher in the grove' do
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

    scenario "teacher can return to all students" do
      grove_playlist_page.visit_page.search_for(student.name).click_on("All Students")

      expect(current_path).to eq(admin_grove_playlist_manager_path)
      expect(grove_playlist_page).to have_content(student.name)
      expect(grove_playlist_page).to have_content(student2.name)
    end

    scenario "teacher can view playlist for a specific student" do
      grove_playlist_page.visit_page
                         .search_for(student.name)
                         .click_on("View Playlist")

      expect(current_path).to eq(admin_student_playlist_path(student))
      expect(grove_playlist_page).to have_content("#{student.name}'s Grove Playlist")
    end
  end

  describe "teacher outside of the grove" do
    before { login(teacher2) }

    it "cannot view students outside of their grove" do
      grove_playlist_page.visit_page
      expect(grove_playlist_page).not_to have_content(student.name)
      expect(grove_playlist_page).not_to have_content(student2.name)
    end
  end

end
