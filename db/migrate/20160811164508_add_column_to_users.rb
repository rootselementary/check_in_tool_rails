class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_image, :string
  end
end
