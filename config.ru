require 'sidekiq'
require 'sidekiq/web'

require_relative "config/environment"

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://localhost:6379" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379" }
end

run Rack::URLMap.new('/sidekiq' => Sidekiq::Web)

run Rails.application
Rails.application.load_server
