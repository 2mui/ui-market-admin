require_relative "boot"

require "rails/all"
# require "active_job/logging"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UiMarketAdmin
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # https://guides.rubyonrails.org/i18n.html
    # https://github.com/svenfuchs/rails-i18n/blob/master/rails/rails5/active_record.yml
    config.i18n.default_locale = :'zh-CN'

    # config.active_storage.variant_processor = :vips

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
