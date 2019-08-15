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
        oembed = yield generate_oembed(talk_form[:link])
        talk_repo.transaction do
          speakers = yield find_or_create_speakers(talk_form[:speakers])
          event   = yield find_or_create_event(talk_form[:event])
          talk    = yield event ? create_talk(talk_form, oembed, event.id) : create_talk(talk_form, oembed)
          yield create_talk_speakers(talk.id, speakers)
          Success(talk)
        end
      end

      private

      def generate_oembed(link)
        Try(OEmbed::Error) { oembed.get(link).html }
      end

      def create_talk_speakers(talk_id, speakers)
        Dry::Monads::List[*speakers.map { |speaker| create_talk_speaker(talk_id, speaker.id) }]
          .typed(Dry::Monads::Result)
          .traverse
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

      def create_talk(talk_form, oembed, event_id = nil)
        talk = talk_repo.create(**talk_form, embed_code: oembed, event_id: event_id) # state `unpublished` by default

        if talk
          Success(talk)
        else
          Failure('could not create talk')
        end
      end

      def find_or_create_speakers(speaker_forms)
        Dry::Monads::List[*speaker_forms.map(&method(:find_or_create_speaker))].typed(Dry::Monads::Result).traverse
      end

      def find_or_create_speaker(speaker_form)
        speaker = speaker_repo.find_or_create(speaker_form)
        speaker ? Success(speaker) : Failure('could not create speaker')
      end

      def find_or_create_event(event_form)
        return Success(nil) unless event_form

        event = event_repo.find_or_create(event_form)
        event ? Success(event) : Failure('could not create event')
      end
    end
  end
end
