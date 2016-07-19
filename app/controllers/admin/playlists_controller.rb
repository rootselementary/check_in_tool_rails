module Admin
  class PlaylistsController < ResourceController
    private

    def authorize_collection
      authorize(:student, :index?)
    end

    def authorize_resource
      @resource = Student.find(params[:student_id]).playlist
      authorize(resource)
    end

    def collection
      Student.where(users: {grove_id: current_user.grove_id})
             .where('name ILIKE ?', "%#{params[:student_search]}%")
             .order('name asc')
             .paginate(page: params[:page], per_page: 25)
    end
  end
end
