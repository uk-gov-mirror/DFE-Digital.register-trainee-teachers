# frozen_string_literal: true

module Page
  module ReviewDraft
    class View < GovukComponent::Base
      attr_reader :trainee, :pre_submission_checker

      def initialize(trainee:)
        @trainee = trainee
        @pre_submission_checker = Trns::SubmissionChecker.call(trainee: trainee)
      end
    end
  end
end
