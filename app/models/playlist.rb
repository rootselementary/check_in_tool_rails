class Playlist < ActiveRecord::Base
  belongs_to :student, foreign_key: 'user_id'
  has_many :playlist_activities
end
