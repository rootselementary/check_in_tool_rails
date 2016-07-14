module Admin
  class TeachersController < ResourceController

    def create
      super do |teacher|
        teacher.password = teacher.password_confirmation = SecureRandom.hex
      end
    end

    protected

    def form_attributes
      [:name, :email]
    end

    def whitelist
      collection_attributes + [:grove_id]
    end

    def collection
      Teacher.where(grove: current_user.grove)
    end

    def after_save_path_for(resource)
      admin_teachers_path
    end

  end
end
