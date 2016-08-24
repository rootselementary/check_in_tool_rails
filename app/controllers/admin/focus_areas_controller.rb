module Admin
  class FocusAreasController < ResourceController

    def collection_attributes
      [:name, :grove_name]
    end

    def collection
      if current_user.admin?
        FocusArea.all
      else
        FocusArea.where(grove: current_grove)
      end
    end

    def whitelist
      [:name, :grove_id]
    end

    def after_save_path_for(resource)
      admin_focus_areas_path
    end
  end
end
