class Admin::GroveMonitorController < ApplicationController

  def index
    authorize(:grove_monitor, :index?)
    @presenter = GroveMonitorPresenter.new(current_user.grove)
    @locations = Location.where(grove_id: current_user.grove_id)
  end

  def show
    if params[:location_id]
      @students = current_user.grove.students.send(filter_params, params[:location_id])
      @location = Location.find(params[:location_id])
    else
      @students = current_user.grove.students.send(filter_params)
      @category = filter_params
    end
    authorize(:grove_monitor, :show?)
  end

  private

    def filter_params
      params[:filter]
    end
end
