class Admin::GroveMonitorController < ApplicationController
  def show
    authorize(:student_management, :show?)
  end
end
