class UpdateStudentsScheduleJob < ActiveJob::Base
  queue_as :default

  def perform
    Student.with_access_token.each do |student|
      UpdateScheduleDailyJob.perform_later(student.id)
    end
  end
end
