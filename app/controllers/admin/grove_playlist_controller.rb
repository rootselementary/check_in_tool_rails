class Admin::GrovePlaylistController < ApplicationController
  def show
    authorize(:student_management, :show?)
  end
end
