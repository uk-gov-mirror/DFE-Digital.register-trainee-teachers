module Dttp
  class Base
    class << self
      def call(**args)
        new(**args).call
      end
    end

    private_class_method :new

    def initialize(trainee:)
      @trainee = trainee
    end

  private

    attr_reader :trainee

    def auth_token
      AccessTokenService.call
    end

    def headers
      {
        "Accept" => "application/json",
        "Content-Type" => "application/json;odata.metadata=minimal",
        "Authorization" => "Bearer #{auth_token}",
      }
    end

    def parse_contactid(response)
      contact_url = response.headers["odata-entityid"]

      if contact_url.blank?
        raise DttpIdNotReturnedError,
              "failed to retrieve the contact id from #{response.headers} with #{response.body} for trainee: #{trainee.id}"
      end

      extract_uuid(contact_url)
    end

    def extract_uuid(string_source)
      uuid_pattern = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
      uuid = string_source.match(uuid_pattern).to_s

      raise DttpIdNotReturnedError, "failed to extract UUID from #{string_source} for trainee: #{trainee.id}" if uuid.blank?

      uuid
    end
  end
end
