class Admin::GroveMonitorController < ApplicationController

  def index
    authorize(:grove_monitor, :index?)
    @presenter = GroveMonitorPresenter.new(current_user.grove)
    @locations = Location.where(grove_id: current_user.grove_id)
  end

  def show
    if params[:name]
      @students = current_user.grove.students.send(filter_params, params[:name])
      @location = Location.find_by_name(params[:name])
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
