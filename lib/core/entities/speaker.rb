# frozen_string_literal: true

class Talk < Hanami::Entity; end

class Speaker < Hanami::Entity
  States = Types::Strict::String.enum('unpublished', 'approved', 'declined')

  attributes do
    attribute :id, Types::Int
    attribute :first_name, Types::String
    attribute :last_name, Types::String
    attribute :slug, Types::String
    attribute :state, States

    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
    attribute :talks, Types::Collection(Talk)
  end
end
