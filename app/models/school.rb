class School < ActiveRecord::Base
  has_many :groves
  has_many :users

  mount_uploader :image, ImageUploader
end
