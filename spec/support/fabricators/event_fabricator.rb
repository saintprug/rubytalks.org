# frozen_string_literal: true

Fabricator(:event, class_name: :event) do
  name { Faker::Book.title }
  city { Faker::Address.city }
  started_at { DateTime.now }
  ended_at { DateTime.now + 1 }
end
