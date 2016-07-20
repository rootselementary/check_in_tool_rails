class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.references :grove, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
