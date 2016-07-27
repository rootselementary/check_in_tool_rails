class UpdateScheduleWorker
#   include Active::Job

  def perform(student_id)
    student = Student.find(student_id)
    scheduled_events = GoogleService.fetch_events(student)
    playlist = student.playlist
    master_calendar = student.grove.master_calendar
    schedule = CalendarZipper.zip(master_calendar, playlist, scheduled_events)
    Redis.set("student-#{{student.id}}",  {schedule: schedule, checksum: Checksum.new(schedule)})
  end
end
