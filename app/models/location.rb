class Location < ActiveRecord::Base
  belongs_to :grove
  has_many :activities

  mount_uploader :image, ImageUploader
end
