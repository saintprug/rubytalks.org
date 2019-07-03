# frozen_string_literal: true

module Admin
  module Controllers
    module Dashboard
      class Index
        include Admin::Action
        include Dry::Monads::Result::Mixin
        # TODO: add pagination
        # include Hanami::Pagination::Action
        include Import[
          operation: 'talks.operations.list_for_approve'
        ]

        expose :talks

        def call(params)
          result = operation.call(params)

          case result
          when Success
            @talks = result.value!
          else
            halt 400, 'Something went wrong'
          end
        end
      end
    end
  end
end
