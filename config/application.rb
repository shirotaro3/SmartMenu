require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SmartMenu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    # タイムゾーンをJSTに設定
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # cannot render console防止
    # unless Rails.env.production?
    #   config.web_console.whitelisted_ips = '10.0.2.2'
    # end
    # slack通知先
    config.slack_webhook_url = 'https://hooks.slack.com/services/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'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
