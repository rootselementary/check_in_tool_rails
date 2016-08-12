require 'google/apis/drive_v2'
require 'google/apis/calendar_v3'

class GoogleService
  def self.fetch_events(student)
    cal = Google::Calendar.new(client_id: ENV['GOOGLE_CLIENT_ID'],
                               client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                               calendar: student.email,
                               redirect_url: "urn:ietf:wg:oauth:2.0:oob",
                               refresh_token: student.refresh_token)

    start_day = Time.zone.today.beginning_of_day
    end_day   = Time.zone.today.end_of_day

    cal.find_events_in_range(start_day, end_day)
  end

  def self.push_notifications(student)
    client = Google::Apis::CalendarV3::CalendarService.new
    authorization = Signet::OAuth2::Client.new(
      :authorization_uri =>
        'https://accounts.google.com/o/oauth2/auth',
      :token_credential_uri =>
        'https://accounts.google.com/o/oauth2/token'
    )
    authorization.client_id = ENV['GOOGLE_CLIENT_ID']
    authorization.client_secret = ENV['GOOGLE_CLIENT_SECRET']
    authorization.grant_type = 'refresh_token'
    authorization.refresh_token = student.refresh_token
    authorization.fetch_access_token!
    client.authorization = authorization

    channel = Google::Apis::CalendarV3::Channel.new(address: 'https://31ea66ce.ngrok.io/notifications', id: student.id, type: "web_hook")
    client.watch_event(student.email, channel, single_events: true)
  end
end
