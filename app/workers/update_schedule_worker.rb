class UpdateScheduleWorker
  include Sidekiq::Worker

  def perform
    Student.all.each do |student|
      UpdateScheduleDailyJob.perform_now(student.id)
    end
  end
end
