class Admin::DashboardController < ApplicationController
  def show
    authorize(:admin_dashboard, :show?)
  end
end
