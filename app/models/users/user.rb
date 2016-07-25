class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
         :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  belongs_to :school
  belongs_to :grove

  def self.from_omniauth(access_token)
    data = access_token.info
    if within_roots?(access_token)
      if Teacher.is_teacher?(data)
        user = Teacher.where(email: data["email"]).first
        user = check_or_create_token(user, access_token)
      elsif Student.is_student?(data)
        user = Student.where(email: data["email"]).first
        user = check_or_create_token(user, access_token)
      end
      user
    end
  end

  def self.within_roots?(data)
    data["extra"]["id_info"]["hd"] == "rootselementary.org"
  end

  def self.check_or_create_token(user, access_token)
    unless user.refresh_token
      creds = access_token["credentials"]
      user.update_attributes(token: creds["token"],
                             refresh_token: creds["refresh_token"],
                             expires_at: creds["expires_at"])
    end
    user
  end

  def first_name
    return email unless name
    name.split(" ").first
  end

  def google_auth_token_store
    json = {
      client_id: ENV['GOOGLE_CLIENT_ID'],
      access_token: self.token,
      refresh_token: self.refresh_token,
      scope: ["https://www.googleapis.com/auth/calendar.readonly"],
      expiration_time_millis: self.expires_at
    }.to_json
    {default: json}
  end
end
