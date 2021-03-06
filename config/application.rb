require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wagerly
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.channel         assets: false
    end

    config.SB_LOGIN_URL = 'https://www.sportsbook.ag/cca/customerauthn/pl/login'
    config.SB_WAGERS_URL = "https://www.sportsbook.ag/sbk/sportsbook4/history.sbk"
    config.DEFAULT_PER_PAGE = 20
  end
end
