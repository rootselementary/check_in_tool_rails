class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :title, :string
    add_column :events, :metadata, :json
  end
end
