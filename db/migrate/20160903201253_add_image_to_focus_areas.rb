class AddImageToFocusAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :focus_areas, :image, :string
  end
end
