class AddAtSchoolToUser < ActiveRecord::Migration
  def change
    add_column :users, :at_school, :boolean
  end
end
