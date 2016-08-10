module Admin
  class TeachersController < ResourceController

    def create
      super do |teacher|
        teacher.password = teacher.password_confirmation = SecureRandom.hex
      end
    end

    protected

    def form_attributes
      [:name, :email, :grove_name]
    end

    def collection_attributes
      [:name, :email, :grove_name]
    end
    
    def whitelist
      collection_attributes + [:grove_id, role_ids: []]
    end

    def collection
      Teacher.where(school: current_user.school)
    end

    def after_save_path_for(resource)
      admin_teachers_path
    end

  end
end
