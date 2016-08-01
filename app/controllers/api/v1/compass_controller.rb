class Api::V1::CompassController < Api::V1::BaseController
  def status
    authorize(:compass, :show?)
    render json: { status: current_user.status }
  end
end
