# frozen_string_literal: true

# frozen_string_literal: true

module Speakers
  module Operations
    class Create < Operation
      include Import[
        speaker_repo: 'repositories.speaker'
      ]

      def call(**speaker_form)
        speaker_form[:slug] = generate_slug(speaker_form[:name])
        speaker_repo.create(speaker_form)
      end

      private

      def generate_slug(name)
        name.split.join('_').downcase
      end
    end
  end
end
