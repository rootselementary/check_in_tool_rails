class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :school, index: true, foreign_key: true
      t.references :grove, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
