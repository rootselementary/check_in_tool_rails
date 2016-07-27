class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.references :event, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.boolean :correct
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
