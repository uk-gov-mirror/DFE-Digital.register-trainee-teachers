module ProgrammeDetails
  class Update
    attr_reader :trainee, :programme_detail, :successful

    alias_method :successful?, :successful

    class << self
      def call(**args)
        new(**args).call
      end
    end

    def initialize(trainee:, attributes: {})
      @trainee = trainee

      @programme_detail = ProgrammeDetail.new(trainee: trainee)
      @programme_detail.assign_attributes(attributes)
    end

    def call
      @successful = programme_detail.valid? && trainee.save!

      self
    end
  end
end