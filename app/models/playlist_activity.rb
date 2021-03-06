class PlaylistActivity < ActiveRecord::Base
  belongs_to :student, foreign_key: :user_id
  belongs_to :activity
  belongs_to :focus_area

  validates :activity, presence: true
end
