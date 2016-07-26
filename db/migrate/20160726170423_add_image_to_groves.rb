class AddImageToGroves < ActiveRecord::Migration
  def change
    add_column :groves, :image, :string
  end
end
