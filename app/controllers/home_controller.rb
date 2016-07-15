class HomeController < ApplicationController
  after_action :verify_authorized, except: [:index]

  def index
    redirect_to current_user.after_sign_in_path if user_signed_in?
  end
end
