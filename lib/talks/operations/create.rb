# frozen_string_literal: true

module Talks
  module Operations
    class Create < Operation
      include Import[
        'oembed',
        talk_repo: 'repositories.talk',
        speaker_repo: 'repositories.speaker',
        event_repo: 'repositories.event',
        talks_speakers_repo: 'repositories.talks_speakers',
        create_speaker: 'speakers.operations.create',
        create_event: 'events.operations.create'
      ]

      # get talk url and generate embed code
      # if code successfully generated -> save the record, set approve to false
      # if code is invalid -> doesn't save the record, return error
      # rubocop:disable Metrics/AbcSize
      def call(talk_form)
        link = talk_form.delete(:link)
        talk_form[:embed_code] = oembed.get(link).html

        talk_repo.transaction do
          speaker = find_or_create_speaker(talk_form[:speaker])
          event = find_or_create_event(talk_form[:event])
          talk = talk_repo.create(**talk_form, event_id: event.id)
          talks_speakers_repo.create(talk_id: talk.id, speaker_id: speaker.id)
        end
      end
      # rubocop:enable Metrics/AbcSize

      private

      def find_or_create_speaker(speaker)
        speaker_repo.find_by_name(
          first_name: speaker[:first_name],
          last_name: speaker[:last_name]
        ) || create_speaker.call(speaker)
      end

      def find_or_create_event(event)
        event_repo.find_by_name(name: event[:name]) || create_event.call(event)
      end
    end
  end
end
