# frozen_string_literal: true

Fabricator(:talk) do
  title { Faker::Book.title }
  description { Faker::Movies::Lebowski.quote }
  # rubocop: disable Metrics/LineLength
  embed_code { '<iframe width="100%" height="300px" src="https://www.youtube.com/embed/0nc3SXoObs8" frameborder="0" allowfullscreen></iframe>' }
  # rubocop: enable Metrics/LineLength
  link { 'https://www.youtube.com/watch?v=t99KH0TR-J4' }
  talked_at { Faker::Date.backward(365).to_s }
  created_at { |attrs| Faker::Date.between(attrs[:talked_at], DateTime.now) } # created_at should be > than talked_at
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

Fabricator(:approved_talk, from: :talk) do
  state 'approved'
end

Fabricator(:declined_talk, from: :talk) do
  state 'declined'
end
