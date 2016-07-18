module Admin
  class PlaylistsController < ResourceController

    private

    def authorize_resource
      @resource = Student.find(params[:student_id]).playlist
      authorize(resource)
    end
  end
end
