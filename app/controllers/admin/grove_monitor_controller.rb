class Admin::GroveMonitorController < ApplicationController
  def show
    authorize(:teacher_resource, :show?)
  end
end
