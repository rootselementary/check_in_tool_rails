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
    checked_in_ids = joins(events: [:scans] ).where(at_school: true)
                                      .where("start_time <= ? AND end_time >= ?", Time.now, Time.now )
                                      .where(scans:{correct: true})
                                      .pluck(:id)
    self.where.not(id: checked_in_ids)
  end

end
