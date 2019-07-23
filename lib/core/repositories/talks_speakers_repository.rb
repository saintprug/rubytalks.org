# frozen_string_literal: true

require_relative 'shared/base'

class TalksSpeakersRepository < Hanami::Repository
  include Base

  associations do
    belongs_to :talks
    belongs_to :speakers
  end
end
