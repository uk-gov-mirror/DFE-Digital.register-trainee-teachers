# frozen_string_literal: true

require_relative "base"

module PageObjects
  module Sections
    class PersonalDetails < PageObjects::Sections::Base
      element :status, ".govuk-tag"
    end
  end
end
