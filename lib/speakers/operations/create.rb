# frozen_string_literal: true

module Speakers
  module Operations
    class Create < Operation
      include Import[
        speaker_repo: 'repositories.speaker'
      ]

      def call(**speaker_form)
        speaker = speaker_repo.create(**speaker_form)

        if speaker
          Success(speaker)
        else
          Failure('could not create speaker')
        end
      end
    end
  end
end
