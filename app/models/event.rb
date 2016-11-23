class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :student, foreign_key: :user_id
  belongs_to :activity
  belongs_to :creator, class_name: "User"

  def scanned_in?
    scans.where('scanned_in_at > ? AND scanned_in_at < ?', start_time - Grove::TRANSITION, end_time).present?
  end

  def scans
    Scan.where(correct: true, student:student, location: location)
  end
end
