require_relative "boot"
require "rails/all"

module FramgiaTutorial
  class Application < Rails::Application
    Bundler.require *Rails.groups
    Config::Integrations::Rails::Railtie.preload
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
