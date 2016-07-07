module Admin
  class GrovesController < ResourceController

    protected

    def collection
      current_user.groves
    end

    def whitelist
      [:name]
    end

    def after_save_path_for(resource)
      admin_groves_path
    end

  end
end
