class Teacher < User
  include Rails.application.routes.url_helpers
  has_many :user_roles, foreign_key: 'user_id'
  has_many :roles, through: :user_roles, foreign_key: 'user_id'

  def after_sign_in_path
    admin_dashboard_path
  end

  def admin?
    roles.where(name: Role::ROLES[:admin]).any?
  end
end
