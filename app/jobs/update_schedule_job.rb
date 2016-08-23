class UpdateScheduleJob < ActiveJob::Base
  queue_as :default

  def perform(student_id)
    student = Student.find(student_id)
    scheduled_events = CalendarEventParser.parse_events(GoogleService.fetch_events(student))
    playlist = normalize_playlist(student.rotated_playlist)
    master_calendar = student.grove.master_calendar
    schedule = CalendarZipper.new(master_calendar, scheduled_events, playlist).schedule
    student.events.destroy_all
    schedule.each do |sched|
      student.events.create(NormalizeSchedule.new(sched).hash)
    end
  end

  private

  def normalize_playlist(playlist)
    playlist.map(&:activity).map(&:attributes).each_with_object([]) do |activity, acc|
      activity['activity_id'] = activity.delete('id') and acc.push(activity)
    end
  end

end
