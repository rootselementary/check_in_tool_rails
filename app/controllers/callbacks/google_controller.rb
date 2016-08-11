class Callbacks::GoogleController < ApplicationController
  skip_before_action :verify_authenticity_token
  # after_action :verify_authorized, except: [:watch]
  # This was supposed to be the endpoint to set up push notifications
  # It is not operational right now
  def watch
    student = Student.find(request.env["HTTP_X_GOOG_CHANNEL_ID"].split("-")[1])
    UpdateScheduleJob.perform(student.id)
    binding.pry
  end

end
