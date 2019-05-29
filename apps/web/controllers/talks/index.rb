# frozen_string_literal: true

module Web
  module Controllers
    module Talks
      class Index
        include Web::Action
        include Import[
          operation: 'talks.operations.list'
        ]

        expose :talks

        def call(params)
          @talks = operation.call(params)
        end
      end
    end
  end
end
