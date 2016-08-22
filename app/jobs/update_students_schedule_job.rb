class UpdateStudentsScheduleJob < ActiveJob::Base
  queue_as :default

  def perform
    Student.all.each do |student|
      UpdateScheduleDailyJob.perform_later(student.id)
    end
  end
end
