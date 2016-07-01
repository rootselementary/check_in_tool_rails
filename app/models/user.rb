class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
         :validatable#, :omniauthable
  belongs_to :school
  belongs_to :grove
  belongs_to :role
  before_create :set_default_role

  private
    def set_default_role
      self.role ||= Role.find_by(name: 'student')
    end
end
