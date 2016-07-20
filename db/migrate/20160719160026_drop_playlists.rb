class DropPlaylists < ActiveRecord::Migration
  def up
    drop_table :playlists
  end

  def down
    create_table :playlists do |t|
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
