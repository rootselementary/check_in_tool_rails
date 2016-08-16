every 1.day, :at => '6:00 am' do
  runner "UpdateScheduleWorker.perform_now"
end
