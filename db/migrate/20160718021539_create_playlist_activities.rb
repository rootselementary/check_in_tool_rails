class CreatePlaylistActivities < ActiveRecord::Migration
  def change
    create_table :playlist_activities do |t|
      t.references :playlist, index: true, foreign_key: true
      t.references :activity, index: true, foreign_key: true
      t.references :focus_area, index: true, foreign_key: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
