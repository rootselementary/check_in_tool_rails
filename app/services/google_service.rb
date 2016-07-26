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
    binding.pry

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
