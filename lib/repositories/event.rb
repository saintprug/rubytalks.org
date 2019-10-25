# frozen_string_literal: true

module Repositories
  class Event < ROM::Repository[:events]
    include Import.args[:rom]

    commands :create, update: :by_pk

    def all
      events.to_a
    end

    def find_or_create(event_form)
      event = find_by_name(name: event_form[:name])
      event || create(**event_form)
    end

    def find_by_name(name:)
      root
        .where(name: name)
        .one
    end

    def find_with_talks(id:)
      events
        .combine(:talks)
        .with_state('approved')
        .by_pk(id)
        .one!
    end

    def order_by_ended_at
      root.order(:ended_at)
    end
  end
end
