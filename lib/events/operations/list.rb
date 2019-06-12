# frozen_string_literal: true

module Events
  module Operations
    class List < Operation
      include Import[
        event_repo: 'repositories.event'
      ]

      def call(_params)
        Success(event_repo.latest)
      end
    end
  end
end
