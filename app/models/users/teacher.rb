class Teacher < User
  has_many :user_roles, foreign_key: 'user_id'
  has_many :roles, through: :user_roles, foreign_key: 'user_id'
end
