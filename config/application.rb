require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CheckInTool
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Mountain Time (US & Canada)'
    config.autoload_paths += %W(#{config.root}/app/models/users)
    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths += %W(#{config.root}/app/channels)
  end
end
