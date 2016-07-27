require 'rubygems'
require 'google_calendar'

class GoogleService
  def self.fetch_events(student)
    cal = Google::Calendar.new(client_id: ENV['GOOGLE_CLIENT_ID'],
                               client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                               calendar: student.email,
                               redirect_url: "urn:ietf:wg:oauth:2.0:oob",
                               refresh_token: student.refresh_token)

    start_day = Date.today.beginning_of_day + 6.hours
    end_day   = Date.today.end_of_day + 6.hours

    cal.find_events_in_range(start_day, end_day)
  end
end
