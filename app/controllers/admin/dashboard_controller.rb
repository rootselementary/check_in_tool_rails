class Admin::DashboardController < ApplicationController
  after_action :verify_authorized, except: [:show]

  def show
    authorize(:admin_dashboard, :show?)
  end
end
