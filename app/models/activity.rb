class Activity < ActiveRecord::Base
  belongs_to :grove
  belongs_to :location
  has_many :playlist_activities, dependent: :destroy
  validates :location, presence: true

  mount_uploader :image, ImageUploader
end
