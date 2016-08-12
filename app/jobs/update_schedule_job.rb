class UpdateScheduleJob < ActiveJob::Base
  queue_as :default

  def self.perform(student_id)
    student = Student.find(student_id)
    scheduled_events = CalendarEventParser.parse_events(GoogleService.fetch_events(student))
    playlist = student.playlist_activities
    master_calendar = student.grove.master_calendar
    schedule = CalendarZipper.new(master_calendar, playlist, scheduled_events).schedule
    student.events.destroy_all
    schedule.each do |sched|
      student.events.create(sched)
    end
  end
end
