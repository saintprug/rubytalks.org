# frozen_string_literal: true

class TalksSpeakersRepository < Hanami::Repository
  associations do
    belongs_to :talks
    belongs_to :speakers
  end
end
