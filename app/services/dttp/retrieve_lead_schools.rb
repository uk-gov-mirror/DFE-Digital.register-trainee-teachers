# frozen_string_literal: true

module Dttp
  class RetrieveLeadSchool
    include ServicePattern

    class HttpError < StandardError; end

    def initialize; end

    def call
      response = Client.get("/accounts?$filter=dfe_isteachingschool eq true and _dfe_institutiontypeid_value eq not null")

      if response.code != 200
        raise HttpError, "status: #{response.code}, body: #{response.body}, headers: #{response.headers}"
      end

      JSON(response.body)["value"]
    end
  end
end
