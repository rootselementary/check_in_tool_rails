class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  after_action :verify_authorized

  protect_from_forgery with: :exception

  def current_grove
    if current_user.admin?
      Grove.find(session[:current_grove_id]) || current_user.grove
    else
      current_user.grove
    end
  end

end
