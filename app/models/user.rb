class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
         :validatable#, :omniauthable
  belongs_to :school
  belongs_to :grove
  belongs_to :role
end
