# frozen_string_literal: true

class Speaker < Hanami::Entity; end
class Event < Hanami::Entity; end

class Talk < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :event_id, Types::Int
    attribute :event, Types::Entity(Event)

    attribute :title, Types::String
    attribute :description, Types::String
    attribute :link, Types::String
    attribute :embed_code, Types::String
    attribute :speakers, Types::Collection(Speaker)
    attribute :talked_at, Types::DateTime
    attribute :state, ::Core::Types::States

    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
  end
end
