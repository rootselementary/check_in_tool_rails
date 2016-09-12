class FocusArea < ActiveRecord::Base
  belongs_to :grove

  mount_uploader :image, FocusAreaUploader

  def grove_name
    grove.name
  end
end
