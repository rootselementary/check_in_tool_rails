class Users::SessionsController < Devise::SessionsController
  after_action :verify_authorized, except: [:new, :create, :destroy]
  def create
    super do |_session|
      flash[:notice] = I18n.t "devise.sessions.hello", first_name: current_user.first_name
    end
  end

  def after_sign_in_path_for(resource)
    resource.after_sign_in_path
  end
end
