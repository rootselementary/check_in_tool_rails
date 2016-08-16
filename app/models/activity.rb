class Activity < ActiveRecord::Base
  belongs_to :grove
  belongs_to :location
  has_many :playlist_activities, dependent: :destroy
  validates :location, presence: true

  mount_uploader :image, ImageUploader

  def self.for_user(user)
    select('activities.*, locations.name as location_name')
      .joins(:location)
      .where(grove_id: user.grove_id)
      .order(title: :asc)
  end
end
