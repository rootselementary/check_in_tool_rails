class AddExpiresAtToScan < ActiveRecord::Migration[5.0]
  def change
    add_column :scans, :expires_at, :datetime
    rename_column :scans, :timestamp, :scanned_in_at
  end
end
