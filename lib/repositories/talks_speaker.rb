# frozen_string_literal: true

module Repositories
  class TalksSpeaker < ROM::Repository[:talks_speakers]
    include Import.args[:rom]

    commands :create

    def all
      talks_speakers.to_a
    end
  end
end
