# frozen_string_literal: true

class Speaker < Hanami::Entity; end
class Event < Hanami::Entity; end

class Talk < Hanami::Entity
  States = Types::Strict::String.enum('unpublished', 'approved', 'declined')

  attributes do
    attribute :id, Types::Int

    attribute :event_id, Types::Int
    attribute :event, Types::Entity(Event)

    attribute :title, Types::String
    attribute :description, Types::String
    attribute :embed_code, Types::String
    attribute :speakers, Types::Collection(Speaker)
    attribute :talked_at, Types::DateTime
    attribute :state, States

    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
  end

  # Trying to add aasm to hanami entity
  # include AASM
  #
  # def initialize
  # end
  #
  # aasm(:state) do
  #   state :unpublished, initial: true
  #   state :approved, :declined
  #
  #   event :publish do
  #     transitions from: :unpublished, to: :approved, if: :unpublished?
  #   end
  #
  #   event :unpublish do
  #     transitions from: :approved, to: :approved, if: :unpublished?
  #   end
  # end
end
