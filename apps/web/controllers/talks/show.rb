# frozen_string_literal: true

module Web
  module Controllers
    module Talks
      class Show < Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'talks.operations.find_approved'
        ]

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @talk = result.value!
          when Failure
            halt 404, 'Talk not found :('
          end
        end
      end
    end
  end
end
