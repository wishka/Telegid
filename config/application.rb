require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NewBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.active_job.queue_adapter = :sidekiq
    config.active_storage.variant_processor = :mini_magick
    # Configuration for the application, engines, and railties goes here.
    config.action_view.embed_authenticity_token_in_remote_forms = true
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.action_mailer.default_url_options = { host: "example.com" }
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
