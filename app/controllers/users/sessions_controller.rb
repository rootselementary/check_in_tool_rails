class Users::SessionsController < Devise::SessionsController
  after_action :verify_authorized, except: [:new, :create, :destroy]
end
