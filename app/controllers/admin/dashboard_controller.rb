class Admin::DashboardController < ApplicationController
  def show
    authorize(:admin_dashboard, :show?)
    @groves = Grove.all
  end
end
