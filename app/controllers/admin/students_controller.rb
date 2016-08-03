module Admin
  class StudentsController < ResourceController

    def create
      super do |student|
        student.password = student.password_confirmation = SecureRandom.hex
      end
    end

    protected

    def after_save_path_for(resource)
      admin_students_path
    end

    def whitelist
      [:name, :email, :grove_id]
    end

    def form_attributes
      whitelist
    end

    def collection_attributes
      [:name, :email, :grove_name]
    end

  end
end
