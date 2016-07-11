class Admin::GroveMonitorController < ApplicationController
  def show
    authorize(:teacher, :show?)
  end
end
