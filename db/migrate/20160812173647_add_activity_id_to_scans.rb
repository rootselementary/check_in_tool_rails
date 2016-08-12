class AddActivityIdToScans < ActiveRecord::Migration
  def change
    add_column :scans, :activity_id, :integer
  end
end
