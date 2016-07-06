class Student < User
  include Rails.application.routes.url_helpers

  def after_sign_in_path
    compass_path
  end
end
