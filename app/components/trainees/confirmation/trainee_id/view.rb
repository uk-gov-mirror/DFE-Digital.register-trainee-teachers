# frozen_string_literal: true

module Trainees
  module Confirmation
    module TraineeId
      class View < GovukComponent::Base
        attr_accessor :trainee

        delegate :trainee_id, to: :trainee

        def initialize(trainee:)
          @trainee = trainee
        end
      end
    end
  end
end
