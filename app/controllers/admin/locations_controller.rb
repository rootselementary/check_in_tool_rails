module Admin
  class LocationsController < ResourceController

    def qr
      build_and_authorize_qr
      render layout: "compass_application"
    end

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

    def build_and_authorize_qr
      location = Location.find(params[:id])
      authorize(location, :show?)
      @qr = RQRCode::QRCode.new("#{checkin_location_url(location)}", :size => 10, :level => :h)
    end

  end
end
