# frozen_string_literal: true

module Trainees
  module RecordActions
    class View < GovukComponent::Base
      include ApplicationHelper

      attr_reader :trainee

      def initialize(trainee)
        @trainee = trainee
      end

      def display_actions?
        trainee.submitted_for_trn? || trainee.trn_received? || trainee.deferred?
      end

      def can_recommend_for_qts?
        trainee.trn_received?
      end

      def action_links
        return reinstate_link + " or " + withdraw_link if trainee.deferred?

        defer_link + " or " + withdraw_link
      end

    private

      def defer_link
        govuk_link_to t("views.trainees.edit.defer"), trainee_deferral_path(trainee), class: "defer"
      end

      def withdraw_link
        govuk_link_to t("views.trainees.edit.withdraw"), trainee_withdrawal_path(trainee), class: "withdraw"
      end

      def reinstate_link
        govuk_link_to t("views.trainees.edit.reinstate"), trainee_reinstatement_path(trainee), class: "reinstate"
      end
    end
  end
end
