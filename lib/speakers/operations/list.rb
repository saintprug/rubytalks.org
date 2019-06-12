# frozen_string_literal: true

module Speakers
  module Operations
    class List < Operation
      include Import[
        speaker_repo: 'repositories.speaker'
      ]

      def call(_params)
        Success(speaker_repo.all)
      end
    end
  end
end
