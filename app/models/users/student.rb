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

  def avatar
    "http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?d=identicon"
  end

  def self.lost
    where.not(id: checked_in_ids)
  end

  def self.location(name)
    location = Location.find_by(name: name)
    where(id: checked_in_ids).map do |student|
      student if student.events.last.location == location
    end
  end

  def self.checked_in_ids
    joins(events: [:scans] ).where(at_school: true)
                            .where("start_time <= ? AND end_time >= ?", Time.now, Time.now )
                            .where(scans:{correct: true})
                            .pluck(:id)
  end

  def next_position
    max_position = playlist_activities.maximum(:position)
    max_position ? max_position + 1 : 1
  end

  def current_event
    events.where("start_time <= ? AND end_time >= ?", Time.now, Time.now ).first
  end
end
