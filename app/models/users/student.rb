class Student < User
  include Rails.application.routes.url_helpers
  has_one :playlist, foreign_key: 'user_id'
  after_create :create_student_playlist

  def admin?
    false
  end

  def after_sign_in_path
    compass_path
  end

  def self.is_student?(data)
    Student.where(email: data["email"]).first
  end

  private

  def create_student_playlist
    # student = Student.last
    Playlist.create(student: self) unless playlist
  end
end
