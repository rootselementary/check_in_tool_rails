module Api
  module V1
    module Admin
      class PlaylistActivitiesController < Api::ApiController
        skip_after_action :verify_authorized, only: [:update]
        respond_to :json
        before_action :set_student

        def update
          @student.playlist_activities.each do |activity|
            activity.update(position: new_position(activity.id))
          end
          respond_with @student
        end

        private

          def set_student
            @student = Student.find(playlist_params[:student_id])
          end

          def new_position(id)
            playlist_params[:activities][id.to_s].to_i
          end

          def playlist_params
            params.require(:data)
          end
      end
    end
  end
end
