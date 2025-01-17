# frozen_string_literal: true

module Dttp
  class BatchRequest
    class Error < StandardError; end

    attr_reader :batch_id, :change_set_id, :headers, :change_sets

    def initialize(batch_id: SecureRandom.uuid, change_set_id: SecureRandom.uuid)
      @batch_id = batch_id
      @change_set_id = change_set_id
      @change_sets = []
      @headers = { "Content-Type" => "multipart/mixed;boundary=batch_#{batch_id}" }
    end

    def add_change_set(entity:, payload:, content_id: SecureRandom.uuid)
      @change_sets << { entity: entity, payload: payload, content_id: content_id }
      content_id
    end

    def submit
      response = Client.post("/$batch", body: body, headers: headers)
      raise Error, "body: #{response.body.gsub('\r', '')}, status: #{response.code}, headers: #{response.headers}" if response.code != 200

      response
    end

  private

    def body
      payload = "--batch_#{batch_id}\n"
      payload += "Content-Type: multipart/mixed;boundary=changeset_#{change_set_id}\n\n"

      change_sets.each { |change_set| payload += change_set_body(change_set) + "\n" }

      payload += "--changeset_#{change_set_id}--\n"
      payload + "--batch_#{batch_id}--\n"
    end

    def change_set_body(change_set)
      <<~BODY
        --changeset_#{change_set_id}
        Content-Type: application/http
        Content-Transfer-Encoding: binary
        Content-ID: #{change_set[:content_id]}

        POST #{Client.base_uri}/#{change_set[:entity]} HTTP/1.1
        Content-Type: application/json;odata.metadata=minimal

        #{change_set[:payload]}
      BODY
    end
  end
end
