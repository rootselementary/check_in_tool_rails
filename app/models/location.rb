class Location < ActiveRecord::Base
  belongs_to :grove
  has_many :activities

  mount_uploader :image, ImageUploader

  def grove_name
    grove.name
  end

  def self.find_by_location(location)
	   where('name = LOWER(?)', location.downcase).first
  end
end
