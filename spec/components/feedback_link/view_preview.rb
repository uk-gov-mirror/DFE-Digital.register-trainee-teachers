# frozen_string_literal: true

require "govuk/components"

module FeedbackLink
  class ViewPreview < ViewComponent::Preview
    def default
      render(FeedbackLink::View.new(enabled: true, feedback_link_url: "https://www.google.com"))
    end
  end
end
