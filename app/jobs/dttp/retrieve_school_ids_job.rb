# frozen_string_literal: true

module Dttp
  class RetrieveSchoolIdsJob < ApplicationJob
    queue_as :default

    def perform
      MapEmployingSchools.call(employing_schools)
      MapLeadSchools.call(lead_schools)
    end

  private

    def employing_schools
      RetrieveEmployingSchools.call
    end

    def lead_schools
      RetrieveLeadSchools.call
    end
  end
end
