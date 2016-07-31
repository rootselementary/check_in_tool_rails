class UpdateScheduleJob < ActiveJob::Base
  queue :default

  def self.perform(student)
    scheduled_events = GoogleService.fetch_events(student)
    playlist = student.playlist_activities
    master_calendar = student.grove.master_calendar
    schedule = CalendarZipper.zip(master_calendar, playlist, scheduled_events)
    checksum = ChecksumHelper.get_checksum(schedule)
    Redis.set("student-#{student.id}",  {schedule: schedule.to_json, checksum: checksum)
  end
end
