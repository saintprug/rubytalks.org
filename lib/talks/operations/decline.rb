# frozen_string_literal: true

module Talks
  module Operations
    class Decline < Operation
      include Import[
        talk_repo: 'repositories.talk',
        speaker_repo: 'repositories.speaker',
        event_repo: 'repositories.event'
      ]

      # set Talk state to 'decline'
      # set Speaker state to 'decline'
      # set Event state to 'decline' if Event presents
      def call(id)
        Try(ROM::TupleCountMismatchError, Hanami::Model::Error) do
          talk = find_talk(id)
          talk_repo.transaction do
            update_talk_state(talk.id)
            update_speakers_state(talk.speakers)
            update_event_state(talk.event_id) if talk.event_id
          end
          Success('Talk declined')
        end.to_result
      end

      private

      def find_talk(id)
        talk_repo.find_with_speakers_and_event(id)
      end

      def update_talk_state(id)
        talk_repo.update(id, state: 'declined')
      end

      def update_speakers_state(speakers)
        speakers.map(&:id).each { |speaker_id| speaker_repo.update(speaker_id, state: 'declined') }
      end

      def update_event_state(event_id)
        event_repo.update(event_id, state: 'declined')
      end
    end
  end
end
