class CompassController < ApplicationController
  after_action :verify_authorized

  def show
    authorize(:compass, :show?)
  end
end
