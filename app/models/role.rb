class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, through: :user_roles
  validates_uniqueness_of :name
  
  ROLES = {
    teacher: 'teacher',
    admin: 'admin'
  }
end
