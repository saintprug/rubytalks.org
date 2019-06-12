# frozen_string_literal: true

module Web
  module Controllers
    module Speakers
      class Index
        include Web::Action
        include Import[
          operation: 'speakers.operations.list'
        ]

        expose :speakers

        def call(params)
          @speakers = operation.call(params).value!
        end
      end
    end
  end
end
