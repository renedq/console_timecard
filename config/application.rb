require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require 'csv'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DrwEvents
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.action_mailer.default_url_options = {:host => 'localhost:3000'}

    config.action_mailer.smtp_settings = {
      :address        => 'smtp.drwholdings.com',
      :port           => 25,
      :domain         => nil,
      :user_name      => nil,
      :password       => nil,
      :authentication => nil
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = 'Central Time (US & Canada)' # This is currently only being used in the Chicago office. We may need to change this in the future.
    config.active_record.default_timezone = :local
  end
end
