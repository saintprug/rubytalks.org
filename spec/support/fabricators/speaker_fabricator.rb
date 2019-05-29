# frozen_string_literal: true

Fabricator(:speaker) do
  name { Faker::Name.name }
  slug { Faker::Internet.slug }
end
