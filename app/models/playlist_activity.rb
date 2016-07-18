class PlaylistActivity < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :activity
  belongs_to :focus_area

  validates :activity, presence: true
end
