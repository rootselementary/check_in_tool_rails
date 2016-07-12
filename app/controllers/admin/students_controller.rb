class Admin::StudentsController < ApplicationController
  def index
    authorize(:teacher, :index?)
    @students = current_user.grove.students
  end
end
