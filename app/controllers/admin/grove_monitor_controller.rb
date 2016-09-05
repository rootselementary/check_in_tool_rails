class Admin::GroveMonitorController < ApplicationController

  def index
    authorize(:grove_monitor, :index?)
    @locations = Location.where(grove_id: current_user.grove_id)
  end

  def show
    authorize(:grove_monitor, :show?)
    if params[:name]
      @students = current_user.grove.students.send(filter_params, params[:name])
      @location = Lo
      cation.find_by_location(params[:name])
    else
      @students = current_user.grove.students.send(filter_params)
      @category = filter_params
    end
  end

  def update
    authorize(:grove_monitor, :index?)
    student = Student.find(params[:id])
    student.update(student_params)
    redirect_to admin_grove_monitor_path(filter: params[:filter],
                                         name: params[:name])
  end

  private

    def student_params
      params.require(:student).permit(:at_school)
    end

    def filter_params
      params[:filter]
    end
end
