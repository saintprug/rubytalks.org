# frozen_string_literal: true

class Talk < Hanami::Entity; end

class Speaker < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :first_name, Types::String
    attribute :last_name, Types::String
    attribute :slug, Types::String

    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
    attribute :talks, Types::Collection(Talk)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
