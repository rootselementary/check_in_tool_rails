class Admin::ActivitiesController < Admin::ResourceController
  def new
<<<<<<< 53cc441b34e298c55dcffade3249989f90a50646
    @locations = Location.where(grove_id: current_user.grove_id)
    super
=======
    @resource = resource_class.new
    @locations = Location.where(grove_id: current_user.grove_id)
    authorize(resource)
    respond_with resource
>>>>>>> Add CRUD functionality for activities; add image uploading
  end

  def create
    super do |activity|
      activity.grove = current_user.grove
    end
  end

  def edit
    @locations = Location.where(grove_id: current_user.grove_id)
    super
  end

  private

    def collection
      Activity.for_user(current_user)
    end

    def collection_attributes
      [:name, :location_name]
    end

    def form_attributes
<<<<<<< 53cc441b34e298c55dcffade3249989f90a50646
      [:name, :image]
=======
      [:name]
>>>>>>> Add CRUD functionality for activities; add image uploading
    end

    def whitelist
      [:name, :image, :location_id]
    end

    def after_save_path_for(resource)
      admin_activities_path
    end
end
