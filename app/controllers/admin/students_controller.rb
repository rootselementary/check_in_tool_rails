module Admin
  class StudentsController < ResourceController

    def create
      super do |student|
        student.password = student.password_confirmation = SecureRandom.hex
      end
    end

    def rebuild_schedule
      @resource = Student.find(params[:student_id])
      authorize(@resource)
      UpdateScheduleJob.perform_later(@resource.id)
      redirect_to after_save_path_for(@resource)
    end

    protected

    def after_save_path_for(resource)
      admin_students_path
    end

    def whitelist
      [:name, :email, :grove_id]
    end

    def form_attributes
      collection_attributes
    end

    def collection_attributes
      [:name, :email, :grove_name]
    end

  end
end
