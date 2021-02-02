# frozen_string_literal: true

module Dttp
  class UpdateTraineeStatus
    include ServicePattern

    ENDPOINTS = {
      contact: "/contacts",
      placement_assignment: "/placementassignments",
    }.freeze

    class Error < StandardError; end

    def initialize(status:, entity_id:, entity_type:)
      @path = ENDPOINTS[entity_type] + "(#{entity_id})"
      @params = Dttp::Params::Status.new(status: status)
    end

    def call
      response = Client.patch(path, body: params.to_json)
      raise Error, response.body if response.code != 204
    end

  private

    attr_reader :path, :params
  end
end