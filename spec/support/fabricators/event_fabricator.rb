# frozen_string_literal: true

Fabricator(:event, class_name: :event) do
  name { Faker::Book.title }
  city { Faker::Address.city }
  started_at { DateTime.now.to_s }
  ended_at { (DateTime.now + 1).to_s }
end

Fabricator(:approved_event, from: :event) do
  state 'approved'
end
