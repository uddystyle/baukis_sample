require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Baukis
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb.yml').to_s]
    config.i18n.default_locale = :ja
    config.load_defaults 5.1
    config.autoload_paths += %W(#{Rails.root}/lib)
    config.eager_load_paths += %W(#{Rails.root}/lib)
    config.generators do |g|
      g.helper false
      g.assets false
      g.test_frameword :rspec
      g.controller_specs false
      g.view_spacs false
    end
  end
end
