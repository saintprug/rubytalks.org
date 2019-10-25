# frozen_string_literal: true

module Web
  module Controllers
    module Speakers
      class Show < Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'speakers.operations.find'
        ]

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            @speaker = result.value!
          when Failure
            halt 404, 'Speaker not found :('
          end
        end
      end
    end
  end
end
