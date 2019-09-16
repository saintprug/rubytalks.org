# frozen_string_literal: true

module Talks
  module Operations
    class FindApproved < Operation
      include Import[
        talk_repo: 'repositories.talk'
      ]

      def call(id:)
        talk = Try(ROM::TupleCountMismatchError) { talk_repo.find_approved_with_speakers_and_event(id) }
        talk.to_result
      end
    end
  end
end
