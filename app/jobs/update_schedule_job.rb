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
      student.events.create(NormalizeSchedule.new(sched).hash)
    end
  end

end
