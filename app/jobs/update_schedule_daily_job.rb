class UpdateScheduleDailyJob < ActiveJob::Base

  def perform(student_id)
    student = Student.find(student_id)
    student.update(at_school: true)
    student.last_activity_id = student.last_activity.try(:id)
    UpdateScheduleJob.perform_now(student_id)
  end
end
