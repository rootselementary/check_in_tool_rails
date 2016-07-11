class Admin::GrovePlaylistController < ApplicationController
  def show
    authorize(:teacher, :show?)
  end
end
