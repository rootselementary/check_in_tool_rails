class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  after_action :verify_authorized
  helper_method :current_grove

  protect_from_forgery with: :exception

  def current_grove
    if current_user.admin? && !session[:current_grove_id].nil?
      Grove.find(session[:current_grove_id])
    else
      current_user.grove
    end
  end

end
