# frozen_string_literal: true

class Talk < Hanami::Entity; end

class Event < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :name, Types::String
    attribute :city, Types::String
    attribute :started_at, Types::DateTime
    attribute :ended_at, Types::DateTime
    attribute :talks, Types::Collection(Talk)

    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
  end
end
