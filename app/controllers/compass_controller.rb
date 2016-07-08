class CompassController < ApplicationController
  after_action :verify_authorized, except: [:logout]
  layout "compass_application"

  def show
    authorize(:compass, :show?)
  end

  def logout
  end
end
