# frozen_string_literal: true

module Dttp
  module Providers
    module Filters
      class View < GovukComponent::Base
        attr_accessor :filters, :filter_actions

        def initialize(filters:, filter_actions: nil)
          @filters = filters
          @filter_actions = filter_actions
        end

        def filter_label_for(filter)
          I18n.t("components.filter.#{filter}")
        end

        def tags_for_filter(filter, value)
          [{ title: title_html(filter, value), remove_link: remove_select_tag_link(filter) }]
        end

      private

        def title_html(filter, value)
          tag.span("Remove ", class: "govuk-visually-hidden") + value + tag.span(" #{filter.humanize.downcase} filter", class: "govuk-visually-hidden")
        end

        def remove_select_tag_link(filter)
          new_filters = filters.reject { |f| f == filter }
          new_filters.to_query.blank? ? nil : "?" + new_filters.to_query
        end
      end
    end
  end
end
