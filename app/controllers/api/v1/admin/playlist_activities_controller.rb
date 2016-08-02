module Api
  module V1
    module Admin
      class PlaylistActivitiesController < Api::ApiController
        respond_to :json
        before_action :set_student

        def update
          @student.playlist_activities.each do |activity|
            activity.update(position: new_position(activity.id))
          end
          respond_with @student
        end

        private

          def playlist_params
            positions = params[:data].try(:fetch, :positions, {}).keys
            params.require(:data).permit(:id, positions: positions)
          end

          def set_student
            @student = Student.find(playlist_params[:id])
          end

          def new_position(id)
            playlist_params[:positions][id.to_s].to_i
          end
      end
    end
  end
end
