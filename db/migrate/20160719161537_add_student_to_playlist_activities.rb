class AddStudentToPlaylistActivities < ActiveRecord::Migration
  def change
    add_reference :playlist_activities, :user, index: true, foreign_key: true
  end
end
