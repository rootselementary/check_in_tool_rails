class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
         :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_and_belongs_to_many :oauth_credentials
  belongs_to :school
  belongs_to :grove

  def self.from_omniauth(access_token)
    data = access_token.info
    if within_roots?(data)
      if Teacher.is_teacher?(data)
        user = Teacher.where(email: data["email"]).first
      elsif Student.is_student?(data)
        user = Student.where(email: data["email"]).first
      end
      user
    end
  end

  def self.within_roots?(data)
    data["email"].include?("rootselementary.org")
  end
end
