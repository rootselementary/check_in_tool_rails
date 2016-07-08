class Users::SessionsController < Devise::SessionsController
  after_action :verify_authorized, except: [:new, :create, :destroy]

  def after_sign_in_path_for(resource)
    resource.after_sign_in_path
  end
end
