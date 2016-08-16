class Callbacks::GoogleController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_after_action :verify_authorized

  def watch
    student = Student.find(request.env["HTTP_X_GOOG_CHANNEL_ID"].split("-")[1])
    UpdateScheduleJob.perform_now(student.id)
    head :created
  end
end
