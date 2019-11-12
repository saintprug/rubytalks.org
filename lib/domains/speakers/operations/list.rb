# frozen_string_literal: true

module Domains
  module Speakers
    module Operations
      class List
        include Operation
        include Import[
          speaker_repo: 'repositories.speaker'
        ]

        def call(_params)
          Success(speaker_repo.all)
        end
      end
    end
  end
end
