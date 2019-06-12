# frozen_string_literal: true

module Utils
  # This class needs for generation initial database
  # state for development environment. It creates 10 speakers.
  # Every Speaker has between 1 and 10 Talks. Every Talk belongs to
  # one Event.
  class Seeder
    def call
      create_talks_with_speaker
      create_speakers_without_talks
      create_talks_with_speaker_and_event
    end

    private

    def create_talks_with_speaker
      puts 'Create talks with speakers'.green
      Fabricate.times(10, :talk_with_speaker)
    end

    def create_speakers_without_talks
      puts 'Create speakers without talks'.green
      Fabricate.times(10, :speaker)
    end

    def create_talks_with_speaker_and_event
      puts 'Create talks with speaker and event'.green
      Fabricate.times(10, :talk_with_speaker_and_event)
    end
  end
end
