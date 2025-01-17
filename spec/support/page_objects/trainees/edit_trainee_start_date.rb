# frozen_string_literal: true

module PageObjects
  module Trainees
    class EditTraineeStartDate < PageObjects::Base
      include PageObjects::Helpers

      set_url "/trainees/{trainee_id}/trainee-start-date/edit"

      element :commencement_date_day, "#trainee_start_date_form_commencement_date_3i"
      element :commencement_date_month, "#trainee_start_date_form_commencement_date_2i"
      element :commencement_date_year, "#trainee_start_date_form_commencement_date_1i"

      element :continue, "input[name='commit']"
    end
  end
end
