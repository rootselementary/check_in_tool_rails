class RemovePlaylistIdFromPlaylistActivities < ActiveRecord::Migration
  def up
    remove_reference(:playlist_activities, :playlist, index: true, foreign_key: true)
  end

  def down
    add_reference(:playlist_activities, :playlist, index: true, foreign_key: true)
  end
end
