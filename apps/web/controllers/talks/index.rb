# frozen_string_literal: true

module Web
  module Controllers
    module Talks
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'talks.operations.list'
        ]

        expose :talks

        def call(params)
          result = operation.call(page: params[:page])

          case result
          when Success
            @talks = result.value![:result]
            @pager = result.value![:pager]
          when Failure
            halt 400, 'Something went wrong'
          end
        end
      end
    end
  end
end
