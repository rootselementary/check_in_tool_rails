class Users::SessionsController < Devise::SessionsController
  after_action :verify_authorized, except: [:new, :create, :destroy, :logout]

  def after_sign_in_path_for(resource)
    resource.after_sign_in_path
  end

  def logout
  end
end
