class AddDurationToEvent < ActiveRecord::Migration
  def change
    add_column :events, :duration, :integer, default: 0
  end
end