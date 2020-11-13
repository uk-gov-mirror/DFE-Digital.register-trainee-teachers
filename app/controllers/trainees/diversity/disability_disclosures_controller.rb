module Trainees
  module Diversity
    class DisabilityDisclosuresController < BaseController
      def edit
        @disability_disclosure = Diversities::DisabilityDisclosure.new(trainee: trainee)
      end

      def update
        updater = Diversities::DisabilityDisclosures::Update.call(
          trainee: trainee,
          attributes: disability_disclosure_params,
        )

        if updater.successful?
          redirect_to_relevant_step
        else
          @disability_disclosure = updater.disability_disclosure
          render :edit
        end
      end

    private

      def trainee
        @trainee ||= Trainee.find(params[:trainee_id])
      end

      def disability_disclosure_params
        return { disability_disclosure: nil } if params[:diversities_disability_disclosure].blank?

        params.require(:diversities_disability_disclosure).permit(*Diversities::DisabilityDisclosure::FIELDS)
      end

      def redirect_to_relevant_step
        if trainee.disability_not_provided? || trainee.not_disabled?
          redirect_to(trainee_diversity_disability_disclosure_confirm_path(trainee))
        else
          redirect_to(edit_trainee_diversity_disability_detail_path(trainee))
        end
      end
    end
  end
end
