# frozen_string_literal: true

class Talk < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :title, Types::String
    attribute :description, Types::String
    attribute :embed_code, Types::String
    attribute :speakers, Types::Collection(Speaker)
    attribute :talked_at, Types::DateTime
    attribute :published, Types::Bool

    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
  end
end
