# frozen_string_literal: true

module Exports
  class TraineeSearchData
    include ExportsHelper


    def initialize(trainees)
      @data_for_export = format_trainees(trainees)
    end

    def data
      header_row ||= FormattedTrainee.headers

      CSV.generate(headers: true) do |rows|
        rows << header_row
        if trainees.empty?
          rows << ["There are 0 trainees that match search criteria"]
        else
          data_for_export.map(&:values).each do |value|
            rows << value.map { |v| sanitize(v) }
          end
        end
      end
    end

    def filename
      "#{Time.zone.now.strftime('%Y-%m-%d_%H-%M_%S')}_Register-trainee-teachers_exported_records.csv"
    end

  private

    attr_reader :data_for_export, :trainees

    def format_trainees(trainees)
      formatted_trainees = []
      Trainee.where(id: trainees.pluck(:id)).includes(:apply_application, :degrees, :end_academic_cycle, :nationalities, :provider, :start_academic_cycle).find_each do |trainee|
        formatted_trainees << FormattedTrainee.call(trainee: trainee)
      end
      formatted_trainees
    end

  end
end
