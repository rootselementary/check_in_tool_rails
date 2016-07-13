class Student < User
  include Rails.application.routes.url_helpers
  has_one :playlist, foreign_key: 'user_id'

  def after_sign_in_path
    compass_path
  end
end
