# frozen_string_literal: true

module Talks
  module Operations
    class Create < Operation
      include Import[
        oembed: 'oembed',
        talk_repo: 'repositories.talk',
        speaker_repo: 'repositories.speaker',
        event_repo: 'repositories.event',
        talks_speakers_repo: 'repositories.talks_speakers',
      ]

      def call(talk_form)
        oembed = yield generate_oembed(talk_form.delete(:link))
        talk_repo.transaction do
          speaker = yield find_or_create_speaker(talk_form[:speaker])
          event   = yield find_or_create_event(talk_form[:event])
          talk    = yield create_talk(talk_form, oembed, event.id)
          yield create_talk_speaker(talk.id, speaker.id)
          Success(talk)
        end
      end

      private

      def generate_oembed(link)
        Try(OEmbed::Error) { oembed.get(link).html }
      end

      # move to approve operation?
      def create_talk_speaker(talk_id, speaker_id)
        talk_speaker = talks_speakers_repo.create(talk_id: talk_id, speaker_id: speaker_id)

        if talk_speaker
          Success(talk_speaker)
        else
          Failure('could not create talk_speaker')
        end
      end

      def create_talk(talk_form, oembed, event_id)
        talk = talk_repo.create(**talk_form, embed_code: oembed, event_id: event_id) # state `unpublished` by default

        if talk
          Success(talk)
        else
          Failure('could not create talk')
        end
      end

      def find_or_create_speaker(speaker_form)
        speaker = speaker_repo.find_by_name(first_name: speaker_form[:first_name], last_name: speaker_form[:last_name])

        if speaker
          Success(speaker)
        else
          new_speaker = speaker_repo.create(**speaker_form) # state `unpublished` by default
          new_speaker ? Success(new_speaker) : Failure('could not create speaker')
        end
      end

      def find_or_create_event(event_form)
        event = event_repo.find_by_name(name: event_form[:name])

        if event
          Success(event)
        else
          new_event = event_repo.create(**event_form) # state `unpublished` by default
          new_event ? Success(new_event) : Failure('could not create event')
        end
      end
    end
  end
end
