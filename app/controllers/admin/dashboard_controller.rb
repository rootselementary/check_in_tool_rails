class Admin::DashboardController < ApplicationController
  def show
    authorize(:admin_dashboard, :show?)
    @groves = Grove.where.not(name: current_user.grove.name)
  end
end
