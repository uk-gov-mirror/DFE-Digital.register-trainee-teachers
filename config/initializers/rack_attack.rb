# frozen_string_literal: true

Rack::Attack.enabled = (ENV["RACK_ATTACK_ENABLED"] == "true")
Rack::Attack.cache.store = Rails.cache

# Permit no more than 5 requests every 2 minutes from a given IP address
Rack::Attack.throttle("requests by ip", limit: 5, period: 120) do |request|
  if request.path == "/request-sign-in-code" && request.post?
    request.ip
  end
end
