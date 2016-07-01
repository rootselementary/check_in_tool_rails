class Teacher < User
  has_many :roles, through: :user_roles
  
  before_create :set_default_role

  private
    def set_default_role
      self.role ||= Role.find_by(name: 'student')
    end

end
