class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
         :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  belongs_to :school
  belongs_to :grove

  has_many :playlist_activities, dependent: :destroy

  def self.from_omniauth(package)
    user = User.where(email: package.email).first
    if user.present?
      user.set_token(package) unless user.refresh_token
      user.google_image = package.image
      user.save if user.changed?
    end
    user
  end

  def set_token(package)
    self.token = package.token
    self.refresh_token = package.refresh_token
    self.expires_at = package.expires_at
  end

  def has_refresh_token?
    self.refresh_token.present?
  end

  def first_name
    return email unless name
    name.split(' ').first
  end

  def teacher?
    false
  end

  class OmniauthPackage

    attr_accessor :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def data
      access_token.info
    end

    def credentials
      access_token['credentials']
    end

    def email
      data['email']
    end

    def image
      data['image']
    end

    def domain
      data['extra']['id_info']['hd']
    end

    def token
      credentials['token']
    end

    def refresh_token
      credentials['refresh_token']
    end

    def expires_at
      credentials['expires_at']
    end
  end
end
