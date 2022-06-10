# frozen_string_literal: true

module ApplyApi
  class ImportApplicationsJob < ApplicationJob
    queue_as :default

    def perform(from_date: nil, recruitment_cycle_years: Settings.apply_applications.import.recruitment_cycle_years)
      @from_date = from_date

      return unless FeatureService.enabled?("import_applications_from_apply")

      reset_last_successful_sync

      recruitment_cycle_years.each do |recruitment_cycle_year|
        new_applications(recruitment_cycle_year).each do |application_data|
          ImportApplication.call(application_data: application_data)
        rescue ApplyApi::ImportApplication::ApplyApiMissingDataError => e
          Sentry.capture_exception(e)
        end
      end
    end

  private

    def new_applications(recruitment_cycle_year)
      RetrieveApplications.call(changed_since: @from_date || last_successful_sync,
                                recruitment_cycle_year: recruitment_cycle_year)
    end

    def last_successful_sync
      @last_successful_sync ||= ApplyApplicationSyncRequest.successful.maximum(:created_at)
    end

    def reset_last_successful_sync
      @last_successful_sync = nil
    end
  end
end
