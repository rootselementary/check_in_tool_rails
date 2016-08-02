class Admin::GroveMonitorController < ApplicationController

  def index
    @presenter = GroveMonitorPresenter.new(current_user.grove)
    authorize(:grove_monitor, :index?)
  end

  def show
    authorize(:grove_monitor, :show?)
    if params[:name]
      @students = current_user.grove.students.send(filter_params, params[:name])
    else
      @students = current_user.grove.students.send(filter_params)
    end
    @locations = current_user.grove.locations
  end

  def update
    authorize(:grove_monitor, :index?)
    student = Student.find(params[:id])
    if student.at_school
      student.update(student_params)
    else
      student.update(student_params)
    end
    redirect_to admin_grove_monitor_all_path
  end

  private

    def student_params
      params.require(:student).permit(:at_school)
    end

    def filter_params
      params[:filter] || :all
    end
end
