require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Managing Playlist Activities' do
  let(:grove) { create(:grove_with_resources) }
  let(:teacher) { grove.teachers.first }
  let(:student) { grove.students.first }
  let(:student2) { grove.students.last }
  let(:activity) { grove.activities.first }
  let(:location) { grove.locations.first }
  let(:focus_area) { grove.focus_areas.first }
  let(:grove_playlist_page) { Pages::GrovePlaylistPage.new }

  describe "a teacher" do
    before { login(teacher) }

    it "can view a student playlist with activities" do
      grove_playlist_page.visit_page.view_playlist(student.name)
      expect(grove_playlist_page).to have_content "#{student.name}'s Grove Playlist"
      expect(grove_playlist_page).to have_content activity.name
      expect(grove_playlist_page).to have_content location.name
      expect(grove_playlist_page).to have_content focus_area.name
    end

    it "can add an activity to a playlist" do
      grove_playlist_page.visit_page
                         .view_playlist(student2.name)
                         .add_new_activity(activity, focus_area)

      expect(grove_playlist_page).to have_content activity.name
      expect(grove_playlist_page).to have_content location.name
      expect(grove_playlist_page).to have_content focus_area.name
    end

    it "can add an activity to a playlist without focus area" do
      grove_playlist_page.visit_page
                         .view_playlist(student2.name)
                         .add_new_activity(activity)

      expect(grove_playlist_page).to have_content activity.name
      expect(grove_playlist_page).to have_content location.name
    end
  end

end
