# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class Update
        include Operation
        include Import[
          oembed: 'oembed',
          talk_repo: 'repositories.talk',
          speaker_repo: 'repositories.speaker',
          event_repo: 'repositories.event',
          talks_speakers_repo: 'repositories.talks_speaker'
        ]

        # 1. Update Talk and Speakers
        # 2. Create Event if event_id blank otherwise update Event
        # TODO: add possibility to create new Speakers
        def call(id, talk_form)
          oembed = yield generate_oembed(talk_form[:link])
          talk_repo.transaction do
            event = yield create_or_update_event(talk_form[:event])
            talk = yield update_talk(id, talk_form, oembed, event)
            yield update_speakers(talk_form[:speakers]) # Success([Speaker #1, Speaker #2])
            Success(talk)
          end
        end

        private

        def generate_oembed(link)
          Try(OEmbed::Error) { oembed.get(link).html }.to_result
        end

        def update_talk(id, talk_form, oembed, event = nil)
          talk = talk_repo.update(id, **talk_form, embed_code: oembed, event_id: event&.id)
          if talk
            Success(talk)
          else
            Failure('could not update talk')
          end
        end

        def update_speakers(speaker_forms)
          Dry::Monads::List[*speaker_forms.map(&method(:update_speaker))].typed(Dry::Monads::Result).traverse
        end

        def update_speaker(speaker_form)
          updated_speaker = speaker_repo.update(speaker_form[:id], **speaker_form)
          updated_speaker ? Success(updated_speaker) : Failure('could not update speaker')
        end

        def create_or_update_event(event_form)
          return Success(nil) unless event_form

          return update_event(event_form) if event_form[:id]

          new_event = event_repo.create(**event_form)
          new_event ? Success(new_event) : Failure('could not create event')
        end

        def update_event(event_form)
          updated_event = event_repo.update(event_form[:id], **event_form)
          updated_event ? Success(updated_event) : Failure('could not update event')
        end
      end
    end
  end
end
