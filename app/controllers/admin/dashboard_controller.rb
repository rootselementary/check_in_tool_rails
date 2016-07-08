class Admin::DashboardController < ApplicationController
  after_action :verify_authorized, except: [:show]
  layout "teacher_application"

  def show
    authorize(:admin_dashboard, :show?)
  end
end
