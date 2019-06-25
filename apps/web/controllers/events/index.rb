# frozen_string_literal: true

module Web
  module Controllers
    module Events
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'events.operations.list'
        ]

        expose :events

        def call(params)
          result = operation.call(params)

          case result
          when Success
            @events = result.value!
          else
            halt 400, 'Something went wrong'
          end
        end
      end
    end
  end
end
