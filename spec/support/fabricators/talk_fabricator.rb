# frozen_string_literal: true

Fabricator(:talk) do
  title { Faker::Book.title }
  description { Faker::Movies::Lebowski.quote }
  embed_code { '<iframe src="https://www.gmail.com" frameborder="2" width="100%" height="300px"></iframe>' }
  speakers { [Fabricate(:speaker)] }
  talked_at { DateTime.now }
end
