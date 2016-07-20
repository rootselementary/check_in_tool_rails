class CreateFocusAreas < ActiveRecord::Migration
  def change
    create_table :focus_areas do |t|
      t.string :name
      t.references :grove, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
