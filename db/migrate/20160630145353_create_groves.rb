class CreateGroves < ActiveRecord::Migration
  def change
    create_table :groves do |t|
      t.references :school, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
