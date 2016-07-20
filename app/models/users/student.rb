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
    result = []
    result << joins(events: [:scans] ).where(at_school: true)
                                      .where("start_time <= ? AND end_time >= ?", Time.now, Time.now )
                                      .where.not(scans:{correct: true})
    joins(:events).where(at_school: true)
                  .where("start_time <= ? AND end_time >= ?", Time.now, Time.now).each do |student|
                    result << student if student.events.last.scans.count == 0
                  end

    result.flatten
  end

end
