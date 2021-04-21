# frozen_string_literal: true

class SchoolSearch
  include ServicePattern

  attr_reader :query, :limit, :lead_schools_only

  def initialize(query: nil, limit: nil, lead_schools_only: false)
    @query = query
    @limit = limit
    @lead_schools_only = lead_schools_only
  end

  def call
    schools = School.open
    schools = schools.search(query) if query
    schools = schools.limit(limit) if limit
    schools = schools.lead_only if lead_schools_only
    schools
  end
end
