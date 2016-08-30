desc "Update Schedule Daily Worker"

task :update_schedules => :environment do
  UpdateStudentsScheduleJob.perform_now
end
