class CompassController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:logout]
  layout "compass_application"

  def show
    authorize(:compass, :show?)
    @compass = CompassPresenter.new(current_user)
  end

  def checkin
    authorize(:compass, :show?)
    scan = ScanCreator.create(current_user, scan_params)
    redirect_to compass_path
  end

  def logout
  end

  private

    def scan_params
      params.permit(:location_id, :scanned_data)
    end
end
