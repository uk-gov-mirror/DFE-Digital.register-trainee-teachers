# frozen_string_literal: true

require "govuk/components"

class Page::ReviewDraft::ViewPreview < ViewComponent::Preview
  def default_trainee
    render(Page::ReviewDraft::View.new(trainee: Trainee.new(id: 1)))
  end
end
