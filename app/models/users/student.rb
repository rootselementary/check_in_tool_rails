class Student < User
  include Rails.application.routes.url_helpers

  def admin?
    false
  end

  def after_sign_in_path
    compass_path
  end

  def self.is_student?(data)
    Student.where(email: data["email"]).first
  end
end
