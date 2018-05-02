require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec,
                        fixtures: true,
                        view_spec: false,
                        helper_specs: false,
                        routing_specs: false,
                        request_specs: false,
                        controller_spec: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
