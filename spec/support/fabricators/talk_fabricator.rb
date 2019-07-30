# frozen_string_literal: true

Fabricator(:talk) do
  title { Faker::Book.title }
  description { Faker::Movies::Lebowski.quote }
  # rubocop: disable Metrics/LineLength
  embed_code { '<iframe width="100%" height="300px" src="https://www.youtube.com/embed/0nc3SXoObs8" frameborder="0" allowfullscreen></iframe>' }
  # rubocop: enable Metrics/LineLength
  talked_at { DateTime.now }
  link { 'https://www.youtube.com/watch?v=t99KH0TR-J4' }
end

Fabricator(:talk_with_speaker, from: :talk) do
  after_create do |talk|
    speaker_id = Fabricate.create(:speaker).id
    TalksSpeakersRepository.new.create(speaker_id: speaker_id, talk_id: talk.id)
  end
end

Fabricator(:talk_with_speaker_and_event, from: :talk_with_speaker) do
  event_id { Fabricate.create(:event).id }
end
