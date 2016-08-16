class UpdateScheduleJob < ActiveJob::Base
  queue_as :default

  def perform(student_id)
    student = Student.find(student_id)
    scheduled_events = CalendarEventParser.parse_events(GoogleService.fetch_events(student))
    playlist = student.rotated_playlist.map(&:activity).map(&:attributes)
    master_calendar = student.grove.master_calendar
    schedule = CalendarZipper.new(master_calendar, scheduled_events, playlist).schedule
    student.events.destroy_all
    schedule.each do |sched|
      sched.delete("id")
      sched.delete("grove_id")
      sched.delete("image")
      student.events.create(sched)
    end
  end

  # class ActivityPresenter
  #   def initialize(playlist_activity)
  #     @activity = playlist_activity.activity
  #   end
  #
  #   def attributes
  #     { id: @activity.id, name: @activity.name }
  #   end
  # end
end
