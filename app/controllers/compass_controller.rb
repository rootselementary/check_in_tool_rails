class CompassController < ApplicationController
  after_action :verify_authorized, except: [:logout]
  layout "compass_application"

  def show
    authorize(:compass, :show?)
    @compass = CompassPresenter.new(current_user)
  end

  def checkin
    authorize(:compass, :show?)
    scan = ScanCreator.new(current_user, scan_params)
    if scan.save
      ActionCable.server.broadcast 'monitor',
        data: scan
      head :ok
    end  
  end

  def logout
  end

  private

    def scan_params
      params.permit(:location_id, :scanned_data)
    end
end
