class Activity < ActiveRecord::Base
  belongs_to :grove
  belongs_to :location
  has_many :playlist_activities
end
