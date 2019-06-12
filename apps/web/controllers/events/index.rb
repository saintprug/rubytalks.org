# frozen_string_literal: true

module Web
  module Controllers
    module Events
      class Index
        include Web::Action
        include Import[
          operation: 'events.operations.list'
        ]

        expose :events

        def call(params)
          @events = operation.call(params).value!
        end
      end
    end
  end
end
