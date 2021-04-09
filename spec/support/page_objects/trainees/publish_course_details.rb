# frozen_string_literal: true

module PageObjects
  module Trainees
    class CourseOptions < SitePrism::Section
      element :input, "input"
      element :label, "label"
    end

    class PublishCourseDetails < PageObjects::Base
      include PageObjects::Helpers
      set_url "/trainees/{id}/publish-course-details/edit"

      sections :course_options, CourseOptions, ".govuk-radios__item"

      element :submit_button, "input[name='commit']"
    end
  end
end
