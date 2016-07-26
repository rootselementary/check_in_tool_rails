class Admin::GrovesController < Admin::ResourceController

  protected

  def form_attributes
    [:name, :image]
  end

  def collection_attributes
    [:name]
  end

  def collection
    current_user.groves.order(name: :asc)
  end

  def whitelist
    [:name, :image]
  end

  def after_save_path_for(resource)
    admin_groves_path
  end
end
