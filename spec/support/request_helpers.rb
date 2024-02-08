# frozen_string_literal: true

module RequestHelpers
  def api_get(version, endpoint, params: {}, token:)
    get "/api/v#{version}/#{endpoint}", params: params, headers: { Authorization: "Bearer #{token}" }
  end
end
