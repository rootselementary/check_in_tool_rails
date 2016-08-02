class AddMasterCalendarToGroveModel < ActiveRecord::Migration
  def change
    add_column :groves, :master_calendar, :json
  end
end
