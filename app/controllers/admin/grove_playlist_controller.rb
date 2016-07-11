class Admin::GrovePlaylistController < ApplicationController
  def show
    authorize(:admin_grove_playlist, :show?)
  end
end
