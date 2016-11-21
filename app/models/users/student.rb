class Student < User
  include Rails.application.routes.url_helpers
  include Redis::Objects

  value :last_activity_id

  has_many :playlist_activities, foreign_key: :user_id, dependent: :destroy
  has_many :events, foreign_key: :user_id, dependent: :destroy
  has_many :scans, foreign_key: :user_id, dependent: :destroy

  scope :absent, -> { where(at_school: false).order(name: :desc) }
  scope :with_access_token, -> { where.not(refresh_token: nil) }

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
        .order(name: :desc)
  end

  def self.location(name)
    location = Location.find_by(name: name)
    self.joins(:events)
        .where(at_school: true)
        .where("start_time <= ? AND end_time >= ?", Time.now, Time.now )
        .where(events: {location_id: location.id})
        .order(name: :desc)
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
    events.where("start_time <= ? AND end_time >= ?", Time.zone.now, Time.zone.now ).first
  end

  def compass_events
    events
          .where("end_time >= ?", Time.zone.now + Grove::TRANSITION)
          .order(start_time: :asc)
          .limit(2)
  end

  def grove_name
    grove.name
  end

  def scanned_in?
    return false unless current_event
    current_event.scanned_in?
  end

  def last_activity
    scan = scans.includes(:activity)
                .where.not(activity_id: nil)
                .order(created_at: :desc)
                .first
    scan.activity if scan.present?
  end

  def rotated_playlist
    @playlist_activities = playlist_activities.joins(:activity).order('position ASC')
    arr = @playlist_activities.to_a
    offset = arr.index { |x| x.activity.id == last_activity_id.value.to_i } || 0
    arr.rotate!(offset)
  end
end
