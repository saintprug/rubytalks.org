# frozen_string_literal: true

desc 'Populates db with records'
task seeds: :environment do
  puts 'Create talks with speakers'.green
  Fabricate.times(10, :talk_with_speaker)

  puts 'Create speakers without talks'.green
  Fabricate.times(10, :speaker)

  puts 'Create talks with speaker and event'.green
  Fabricate.times(10, :talk_with_speaker_and_event)
end
