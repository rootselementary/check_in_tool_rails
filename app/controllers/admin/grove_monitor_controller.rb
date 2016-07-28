class Admin::GroveMonitorController < ApplicationController

  def index
    @presenter = GroveMonitorPresenter.new(current_user.grove)
    authorize(:grove_monitor, :index?)
  end

  def show
    if params[:name]
      @students = current_user.grove.students.send(filter_params, params[:name])
    else
      @students = current_user.grove.students.send(filter_params)
    end
    @locations = current_user.grove.locations
    authorize(:grove_monitor, :show?)
  end

  def update
    student = Student.find(params[:id])
    student.update_attribute(:at_school, false)
    require "pry"
    binding.pry
    redirect_to admin_grove_monitor_all_path
  end

  private

    def filter_params
      params[:filter] || :all
    end
end
