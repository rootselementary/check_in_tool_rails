module Admin
  class LocationsController < ResourceController

    def show
      super { @qr = RQRCode::QRCode.new("#{resource.id}", :size => 6, :level => :h) }
    end

    protected

    def collection
      if current_user.admin?
        Location.all
      else
        Location.where(grove: current_grove)
      end
    end

    def after_save_path_for(resource)
      admin_locations_path
    end

    def whitelist
      [:name, :grove_id, :image]
    end

    def form_attributes
      whitelist
    end

    def build_and_authorize_qr
      location = Location.find(params[:id])
      authorize(location, :show?)
      @qr = RQRCode::QRCode.new("#{location.id}", :size => 6, :level => :h)
    end

    def collection_attributes
      [:titleized_name, :grove_name, :image]
    end

  end
end
