# frozen_string_literal: true

module Persistence
  module Relations
    class Talks < ROM::Relation[:sql]
      schema(:talks, infer: true) do
        associations do
          has_many :talks_speakers
          has_many :speakers, through: :talks_speakers
          belongs_to :event
        end
      end

      def with_state(state)
        where(state: state)
      end

      def without_state(given_state)
        where { state.not(given_state) }
      end
    end
  end
end
