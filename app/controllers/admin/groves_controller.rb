class Admin::GrovesController < Admin::ResourceController

  protected

  def form_attributes
    [:name]
  end

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
