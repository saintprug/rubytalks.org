# frozen_string_literal: true

module Events
  module Operations
    class Create < Operation
      include Import[
        event_repo: 'repositories.event'
      ]

      def call(**event_form)
        event_repo.create(event_form)
      end
    end
  end
end
