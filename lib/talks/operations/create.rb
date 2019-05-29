# frozen_string_literal: true

module Talks
  module Operations
    class Create < Operation
      include Import[
        'oembed',
        talk_repo: 'repositories.talk',
        speaker_repo: 'repositories.speaker',
        create_speaker: 'speakers.operations.create'
      ]

      # get talk url and generate embed code
      # if code successfully generated -> save the record, set approve to false
      # if code is invalid -> doesn't save the record, return error
      def call(talk_form)
        link = talk_form.delete(:link)
        talk_form[:embed_code] = oembed.get(link).html
        speaker = find_or_create_speaker(talk_form[:speaker])
        talk_repo.create(**talk_form, speaker_id: speaker.id)
      end

      private

      def find_or_create_speaker(speaker)
        speaker_repo.find_by_name(speaker[:name]) || create_speaker.call(speaker)
      end
    end
  end
end
