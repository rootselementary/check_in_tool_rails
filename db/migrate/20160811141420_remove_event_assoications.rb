class RemoveEventAssoications < ActiveRecord::Migration
  def change
    remove_column :scans, :event_id
  end
end
