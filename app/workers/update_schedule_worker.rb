class UpdateScheduleWorker
  include Sidekiq::Worker

  def self.perform
    Student.all.each do |student|
      student.update(at_school: false)
      UpdateScheduleJob.perform(student)
    end
  end
end
