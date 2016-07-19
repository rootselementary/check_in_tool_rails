module Admin
  class TeachersController < ResourceController

    def create
      super do |teacher|
        teacher.password = teacher.password_confirmation = SecureRandom.hex
        teacher.roles << Role.find(role_params) if role_params
      end
    end

    protected

    def role_params
      params.dig("teacher", "role_ids")
    end

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
