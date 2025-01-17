# frozen_string_literal: true

module PageObjects
  module Trainees
    class Create < PageObjects::Base
      set_url "/trainees/new"

      element :trainee_id_field, "#trainee-trainee-id-field"
      element :continue, "input[name='commit']"
    end
  end
end
