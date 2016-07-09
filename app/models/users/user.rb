class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
         :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_and_belongs_to_many :oauth_credentials
  belongs_to :school
  belongs_to :grove

  def self.from_omniauth(access_token)
    data = access_token.info

    if within_roots?(data)
      user = User.where(email: data["email"]).first
      unless user
        user = User.create(name: data["name"],
                           email: data["email"],
                           password: Devise.friendly_token[0,20]
                           )
      end
      user
    else
      user = User.new
    end
  end

  def self.within_roots?(data)
    data["email"].include?("rootselementary.org")
  end
end
