# frozen_string_literal: true

module Events
  module Operations
    class Find < Operation
      include Import[
        event_repo: 'repositories.event'
      ]

      def call(id:)
        event = Try(ROM::TupleCountMismatchError) { event_repo.find_with_talks(id: id) }
        event.to_result
      end
    end
  end
end
