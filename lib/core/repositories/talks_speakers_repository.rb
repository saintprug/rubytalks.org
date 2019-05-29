# frozen_string_literal: true

class TalksSpeakersRepository < Hanami::Repository
  associations do
    belongs_to :speakers
    belongs_to :talks
  end
end
