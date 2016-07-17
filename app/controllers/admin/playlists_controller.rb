module Admin
  class PlaylistsController < ResourceController

    private

    def authorize_resource
      @resource = Student.find(params[:student_id]).playlist
      authorize(resource)
    end

    def collection
      Playlist.includes(:student)
              .where(users: {grove_id: current_user.grove.id})
              .where('name ILIKE ?', "%#{params[:student_search]}%")
              .order('name asc')
              .paginate(page: params[:page], per_page: 25)
    end
  end
end
