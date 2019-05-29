# frozen_string_literal: true

class Speaker < Hanami::Entity
  attributes do
    attribute :name, Types::String
    attribute :slug, Types::String

    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
  end
end
