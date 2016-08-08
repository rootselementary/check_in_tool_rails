class Student < User
  include Rails.application.routes.url_helpers
  has_many :playlist_activities, foreign_key: :user_id
  has_many :events, foreign_key: :user_id
  has_many :scans, foreign_key: :user_id

  scope :absent, -> { where(at_school: false) }

  def admin?
    false
  end

  def after_sign_in_path
    compass_path
  end

  def self.is_student?(data)
    Student.where(email: data["email"]).first
  end

  def self.lost
    self.where(at_school: true)
        .where.not(id: has_event_ids)
  end

  def self.location(name)
    location = Location.find_by(name: name)
    self.joins(:events)
        .where(at_school: true)
        .where("start_time <= ? AND end_time >= ?", Time.now, Time.now )
        .where(events: {location_id: location.id})
  end

  def self.has_event_ids
    self.joins(:events)
        .where(at_school: true)
        .where("start_time <= ? AND end_time >= ?", Time.now, Time.now )
        .pluck(:id)
  end

  def next_position
    max_position = playlist_activities.maximum(:position)
    max_position ? max_position + 1 : 1
  end

  def current_event
    events.where("start_time <= ? AND end_time >= ?", Time.now, Time.now ).first
  end

  def scanned_in?
    return false unless current_event
    current_event.scanned_in?
  end
end
