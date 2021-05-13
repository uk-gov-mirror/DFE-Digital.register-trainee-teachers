# frozen_string_literal: true

module Dttp
  class MapLeadSchools
    include ServicePattern

    class HttpError < StandardError; end

    def initialize(lead_schools)
      @lead_schools = lead_schools
    end

    def map_schools
      lead_schools.each do |school|
        local_school = School.find_by(urn: school["dfe_urn"])
        if local_school
          local_school.dttp_id = school["account_id"]
        end
      end
    end
  end
end
