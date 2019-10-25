module Persistence
  module Relations
    class TalksSpeakers < ROM::Relation[:sql]
      schema(:talks_speakers, infer: true) do
        associations do
          belongs_to :talks
          belongs_to :speakers
        end
      end
    end
  end
end
