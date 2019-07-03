# frozen_string_literal: true

class EventRepository < Hanami::Repository
  associations do
    has_many :talks
  end

  def find_by_name(name:)
    root
      .where(name: name)
      .one
  end

  def find_with_talks(id:)
    root
      .by_pk(id)
      .where(state: 'approved')
      .combine(:talks)
      .map_to(Event)
      .one!
  end

  def latest(amount: 10)
    order_by_ended_at
      .where(state: 'approved')
      .combine(:talks)
      .map_to(Event)
      .limit(amount)
      .to_a
  end

  def order_by_ended_at
    root
      .order(:ended_at)
  end
end
