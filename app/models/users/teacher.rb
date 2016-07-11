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

  def groves
    if admin?
      Grove.where(school: school)
    else
      # even though we have the grove association
      # its better to always return the same type
      # in this case an ActiveRecord::Relation
      Grove.where(id: grove_id)
    end
  end

  def self.is_teacher?(data)
    # binding.pry
    Teacher.where(email: data["email"]).first
  end
end
