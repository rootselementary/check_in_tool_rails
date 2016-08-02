class Api::ApiController < Admin::ResourceController
  protect_from_forgery with: :null_session
end
