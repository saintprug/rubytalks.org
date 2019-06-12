# frozen_string_literal: true

module Speakers
  module Operations
    class Find < Operation
      include Import[
        speaker_repo: 'repositories.speaker'
      ]

      def call(id:)
        talk = Try(ROM::TupleCountMismatchError) { speaker_repo.find_with_talks(id: id) }
        talk.to_result
      end
    end
  end
end
