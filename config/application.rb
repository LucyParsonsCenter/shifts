require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LpcTraining
  class Application < Rails::Application

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # config.time_zone = 'Central Time (US & Canada)'

    config.active_record.raise_in_transactional_callbacks = true

    config.browserify_rails.commandline_options = [
      '-t [ coffee-reactify --extension=".cjsx" --extension=".coffee" ]',
      '--extension=".coffee"',
      '--extension=".cjsx"',
    ]
  end
end
