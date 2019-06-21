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
        create_speaker: 'speakers.operations.create',
        create_event: 'events.operations.create'
      ]

      def call(talk_form) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        generate_oembed(talk_form.delete(:link)).bind do |oembed|
          talk_repo.transaction do
            find_or_create_speaker(talk_form[:speaker]).bind do |speaker|
              find_or_create_event(talk_form[:event]).bind do |event|
                create_talk(talk_form, oembed, event.value!.id).bind do |talk|
                  create_talk_speaker(talk.id, speaker.value!.id).bind do |_|
                    Success(talk)
                  end
                end
              end
            end
          end
        end
      end

      private

      def generate_oembed(link)
        Try(OEmbed::Error) { oembed.get(link).html }
      end

      def create_talk_speaker(talk_id, speaker_id)
        talk_speaker = talks_speakers_repo.create(talk_id: talk_id, speaker_id: speaker_id)

        if talk_speaker
          Success(talk_speaker)
        else
          Failure('could not create talk_speaker')
        end
      end

      def create_talk(talk_form, oembed, event_id)
        talk = talk_repo.create(**talk_form, embed_code: oembed, event_id: event_id, published: false)

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
          new_speaker = create_speaker.call(speaker_form)
          new_speaker ? Success(new_speaker) : Failure('could not create speaker')
        end
      end

      def find_or_create_event(event_form)
        event = event_repo.find_by_name(name: event_form[:name])

        if event
          Success(event)
        else
          new_event = create_event.call(event_form)
          new_event ? Success(new_event) : Failure('could not create event')
        end
      end
    end
  end
end
