# frozen_string_literal: true

module Admin
  module Controllers
    module Talks
      class Edit < Admin::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'talks.operations.find_unapproved'
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
