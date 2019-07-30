# frozen_string_literal: true

Fabricator(:speaker) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  slug { |attrs| "#{attrs[:first_name]}-#{attrs[:last_name]}".downcase }
end

Fabricator(:approved_speaker, from: :speaker) do
  state 'approved'
end
