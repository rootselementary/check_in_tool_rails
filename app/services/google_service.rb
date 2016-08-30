require 'google/apis/drive_v2'
require 'google/apis/calendar_v3'

class GoogleService
  def self.fetch_events(student)
    cal = Google::Calendar.new(client_id: ENV['GOOGLE_CLIENT_ID'],
                               client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                               calendar: student.email,
                               redirect_url: "urn:ietf:wg:oauth:2.0:oob",
                               refresh_token: student.refresh_token)

    calendar  = JSON.parse student.grove.master_calendar

    start_day = to_time(calendar.first)
    end_day   = to_time(calendar.last)

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

  def self.to_time(tuple)
    Time.zone.now.change(hour: tuple[0], min: tuple[1])
  end

end
