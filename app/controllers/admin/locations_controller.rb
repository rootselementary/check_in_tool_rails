module Admin
  class LocationsController < ResourceController

    protected

    def after_save_path_for(resource)
      admin_locations_path
    end

    def whitelist
      [:name, :grove_id, :image]
    end

    def form_attributes
      whitelist
    end

  end
end
