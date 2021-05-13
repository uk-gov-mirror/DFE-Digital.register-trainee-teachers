# frozen_string_literal: true

module Dttp
  class MapEmployingSchools
    include ServicePattern

    class HttpError < StandardError; end

    def initialize(employing_schools)
      @employing_schools = employing_schools
    end

    def map_schools
      employing_schools.each do |school|
        local_school = School.find_by(urn: school["dfe_urn"])
        if local_school
          local_school.dttp_id = school["account_id"]
        end
      end
    end

  private

    attr_reader :employing_schools
  end
end
