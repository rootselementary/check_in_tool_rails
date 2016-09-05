class Admin::ActivitiesController < Admin::ResourceController
  def new
    @locations = Location.where(grove_id: current_grove.id)
    super
  end

  def create
    super do |activity|
      activity.grove = current_user.grove
    end
    ActionCable.server.broadcast 'monitor',
        data: @resource.title
      head :ok
  end

  def edit
    @locations = Location.where(grove_id: current_grove.id)
    super
  end

  private

    def collection
      Activity.for_user(current_user)
    end

    def collection_attributes
      [:title, :location_name]
    end

    def form_attributes
      [:title, :image]
    end

    def whitelist
      [:title, :image, :location_id]
    end

    def after_save_path_for(resource)
      admin_activities_path
    end
end
