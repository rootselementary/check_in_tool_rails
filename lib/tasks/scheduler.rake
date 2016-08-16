desc "Update Schedule Daily Worker"

task :update_schedules => :environment do
  UpdateScheduleWorker.perform_now
end
