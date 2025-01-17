# frozen_string_literal: true

class RecommendForQtsJob < ApplicationJob
  queue_as :default
  retry_on Dttp::RecommendForQTS::Error
  retry_on Dttp::UpdateTraineeStatus::Error

  def perform(trainee)
    Dttp::RecommendForQTS.call(trainee: trainee)

    Dttp::UpdateTraineeStatus.call(
      status: DttpStatuses::STANDARDS_MET,
      trainee: trainee,
      entity_type: ::Dttp::UpdateTraineeStatus::CONTACT_ENTITY_TYPE,
    )

    Dttp::UpdateTraineeStatus.call(
      status: DttpStatuses::STANDARDS_MET,
      trainee: trainee,
      entity_type: ::Dttp::UpdateTraineeStatus::PLACEMENT_ASSIGNMENT_ENTITY_TYPE,
    )
  end
end
