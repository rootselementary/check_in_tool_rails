require 'pry'
require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "calendar-ruby-quickstart.yaml")
# SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials

class GoogleService
  # attr_reader :service

  def initialize(user)
    # @service = Faraday.new("https://www.googleapis.com/calendar/v3/calendars/#{user.email}/events")
    @user = user
  end

  def authorize
    # FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(JSON.parse(ENV['GOOGLE_API_SECRETS']))
    binding.pry
    token_store = Google::Auth::Stores::FileTokenStore.new(user.google_auth_token_store)
    authorizer = Google::Auth::UserAuthorizer.new(
    client_id, "https://www.googleapis.com/auth/calendar.readonly", token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(
      base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the " +
      "resulting code after authorization"
      puts url
      code = gets.chomp
      credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end

  def calendar_request
    # binding.pry
    # Initialize the API
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = 'roots'
    service.authorization = authorize
    binding.pry
    # client = Signet::OAuth2::Client.new(access_token: @user.token)
    # binding.pry
    # service = Google::Apis::CalendarV3::CalendarService.new
    #
    # service.authorization = client

    # @calendar_list = service.list_calendar_lists

    # calendar_id = 'primary'
    response = service.list_events('jj.letest@rootselementary.org',
    time_max: (Time.now + 12.hours).iso8601,
    single_events: true,
    order_by: 'startTime',
    time_min: Time.now.iso8601)
    binding.pry
    # puts "Upcoming events:"
    # puts "No upcoming events found" if response.items.empty?
    # response.items.each do |event|
    #   start = event.start.date || event.start.date_time
    #   puts "- #{event.summary} (#{start})"
    # end

    # Take response and use a CalendarZipper to change it into a json object

    # Produce a hash that looks something like this:
    #
    # {checkSum: "asldjfalufiuwenfawjenfc;asjcn",
    #  schedule: {
    #    [[8,0],[8,30]] => {
    #      location: "Eating Area",
    #      activity: "Breakfast",
    #      creator: "Jill Tew"
    #    },
    #    [[8,30],[9,0]] => {
    #      location: "Classroom A",
    #      activity: "Spelling Lesson",
    #      creator: "JJ Leteach"
    #    },
    #    [[9,0],[10,0]] => {
    #      location: "Writing Center",
    #      acivity: "Writing exercises",
    #      creator: "JJ Leteach"
    #    }
    #    }}
    #
    # schedule = [{starts_at: timestamp,
    #              ends_at: timestamp,
    #              location: string,
    #              description: string,
    #              creator: teacher.id}, {}]
    # render schedule.map{|s| CalenderEventDecorator.new(s) }
  end
end

# job runs on some schedule 15 min?
# class UpdateSchedule
#   include Active::Job
#   def perform(student_id)
#     student = Student.find(student_id)
#     scheduled_events = GoogleService.fetch(student.email).events
#     playlist = student.playlist
#     master_calendar = student.grove.master_calendar
#     schedule = CalendarZipper.zip(master_calendar, playlist, scheduled_events)
#     Redis.set("student-#{{student.id}}",  {schedule: schedule, checksum: Checksum.new(schedule)})
#   end
# end
#
# class CompassController
#
#   # /compass
#   def index
#     vals = Redis.get("student-#{current_user.id}")
#     @checksum = vals[:checksum]
#   end
#
#   # in the index template
#   # $.ajax('/checksum').success(-> if checksum !== $checksum {window.location = '/compass'}).fail(->).always(->)
#
#   # /compass#checksum
#   def checksum
#     vals = Redis.get("student-#{current_user.id}")
#     respond_with vals.checksum
#   end
# end
