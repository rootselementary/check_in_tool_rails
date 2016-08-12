class Callbacks::GoogleController < ApplicationController
  skip_before_action :verify_authenticity_token

  def watch
    student = Student.find(request.env["HTTP_X_GOOG_CHANNEL_ID"].split("-")[1])
    UpdateScheduleJob.perform(student.id)
  end
end
