# frozen_string_literal: true

module Events
  module Operations
    class Create < Operation
      include Import[
        event_repo: 'repositories.event'
      ]

      def call(**event_form)
        event = event_repo.create(event_form)

        if event
          Success(event)
        else
          Failure('could not create event')
        end
      end
    end
  end
end
