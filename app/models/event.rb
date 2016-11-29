class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :student, foreign_key: :user_id
  belongs_to :activity
  belongs_to :creator, class_name: "User"

  # @return [FocusArea, Nil]
  def focus_area
    playlist_activity = PlaylistActivity.includes(:focus_area).where(activity_id: self.activity_id).first
    playlist_activity.focus_area if playlist_activity
  end

  def scanned_in?
    scans.where('scanned_in_at > ? AND scanned_in_at < ?', start_time - Grove::TRANSITION, end_time).present?
  end

  def scans
    Scan.where(correct: true, student:student, location: location)
  end
end
