class ChangeColumnNameOnActivity < ActiveRecord::Migration
  def change
    rename_column :activities, :name, :title
  end
end
