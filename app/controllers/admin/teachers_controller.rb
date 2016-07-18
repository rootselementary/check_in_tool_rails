module Admin
  class TeachersController < ResourceController

    def create
      super do |teacher|
        teacher.password = teacher.password_confirmation = SecureRandom.hex
      end
            
      Teacher.last.roles << Role.find(params.dig("teacher", "role_ids"))
  
    end

    protected

    def form_attributes
      [:name, :email]
    end

    def whitelist
      collection_attributes + [:grove_id, :roles_id]
    end

    def collection
      Teacher.where(school: current_user.school)
    end

    def after_save_path_for(resource)
      admin_teachers_path
    end

  end
end
