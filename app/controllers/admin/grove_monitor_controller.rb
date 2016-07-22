class Admin::GroveMonitorController < ApplicationController

  # /admin/grove_monitor
  # /admin/grove_montior?filter=[lost]
  # /admin/grove_montior?filter=[lost,absent]&teacher=smith
  # link_to("Lost", admin_grove_monitor_path(filter: [lost]))

  def show
    if params[:filter] == "location"
      @students = current_user.grove.students.send(filter_params, params[:name])
    else
      @students = current_user.grove.students.send(filter_params)
    end
    @locations = current_user.grove.locations
    authorize(:teacher_resource, :show?)
  end

  private

    def filter_params
      params[:filter] || :all
    end
end
