module Persistence
  module Relations
    class Speakers < ROM::Relation[:sql]
      schema(:speakers, infer: true) do
        associations do
          has_many :talks_speakers
          has_many :talks, through: :talks_speakers
        end
      end

      def with_state(state)
        where(state: state)
      end
    end
  end
end
