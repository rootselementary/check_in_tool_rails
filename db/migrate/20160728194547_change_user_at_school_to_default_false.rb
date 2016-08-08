class ChangeUserAtSchoolToDefaultFalse < ActiveRecord::Migration
  def change
    change_column :users, :at_school, :boolean, default: false
  end
end
