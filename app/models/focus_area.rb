class FocusArea < ActiveRecord::Base
  belongs_to :grove

  mount_uploader :image, ImageUploader

  def grove_name
    grove.name
  end
end
