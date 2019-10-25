# frozen_string_literal: true

module Web
  module Controllers
    module Events
      class Show < Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'events.operations.find'
        ]

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @event = result.value!
          when Failure
            halt 404, 'Event not found :('
          end
        end
      end
    end
  end
end
