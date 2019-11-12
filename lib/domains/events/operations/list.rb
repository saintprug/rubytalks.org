# frozen_string_literal: true

module Domains
  module Events
    module Operations
      class List
        include Operation
        include Import[
          event_repo: 'repositories.event'
        ]

        def call(_params)
          Success(event_repo.all)
        end
      end
    end
  end
end
