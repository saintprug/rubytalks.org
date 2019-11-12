# frozen_string_literal: true

module Repositories
  class Talk < ROM::Repository[:talks]
    include Import.args[:rom]

    commands :create, update: :by_pk

    def all
      talks.to_a
    end

    def order_by_created_at
      talks.order { created_at.desc }
    end

    # with state `unpublished` and `declined`
    def find_unapproved(id)
      talks
        .combine(:speakers, :event)
        .without_state('approved')
        .by_pk(id)
        .one!
    end

    def find_approved_with_speakers_and_event(id)
      talks
        .combine(:speakers, :event)
        .with_state('approved')
        .by_pk(id)
        .one!
    end

    def find_with_speakers_and_event(id)
      talks
        .combine(:speakers, :event)
        .by_pk(id)
        .one!
    end

    private

    def order_by_date(relation)
      relation.order { talked_at.desc }
    end
  end
end
