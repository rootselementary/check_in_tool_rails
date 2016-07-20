module Admin
  class TeachersController < ResourceController

    def create
      super do |teacher|
        teacher.password = teacher.password_confirmation = SecureRandom.hex
        teacher.roles << Role.find(admin_id) if admin_role?
      end
    end

    protected

    def admin_role?
      params.dig("teacher", "role_ids").to_i == 1
    end

    def admin_id
      Role.find_by(name: Role::ROLES[:admin]).id
    end

    def form_attributes
      [:name, :email]
    end

    def whitelist
      collection_attributes + [:grove_id]
    end

    def collection
      Teacher.where(school: current_user.school)
    end

    def after_save_path_for(resource)
      admin_teachers_path
    end

  end
end
