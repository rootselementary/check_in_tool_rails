class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  after_action :verify_authorized, except: [:new, :create, :destroy, :google_oauth2]

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = "Google account must be within the Roots Elementary Organization."
      redirect_to root_path
    end
  end

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
