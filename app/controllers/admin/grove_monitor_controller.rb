class Admin::GroveMonitorController < ApplicationController
  after_action :verify_authorized, except: [:show]

  def show
    authorize(:admin_grove_monitor, :show?)
  end
end
