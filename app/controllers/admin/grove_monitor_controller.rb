class Admin::GroveMonitorController < ApplicationController
  def show
    authorize(:admin_grove_monitor, :show?)
  end
end
