require 'rubygems'
require 'google_calendar'

class GoogleService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def calendar_request
    cal = Google::Calendar.new(client_id: ENV['GOOGLE_CLIENT_ID'],
                               client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                               calendar: user.email,
                               redirect_url: "urn:ietf:wg:oauth:2.0:oob",
                               refresh_token: user.refresh_token)

    start_day = Date.today.beginning_of_day + 6.hours
    end_day = Date.today.end_of_day + 6.hours

    daily_events = cal.find_events_in_range(start_day, end_day)
  end
end
