class Location < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :grove
  has_many :activities

  mount_uploader :image, ImageUploader
end
