# frozen_string_literal: true

require_relative 'shared/base'
require_relative 'shared/stateable'

class EventRepository < Hanami::Repository
  include Base
  include Stateable

  associations do
    has_many :talks
  end

  def find_by_name(name:)
    root
      .where(name: name)
      .one
  end

  def find_with_talks(id:)
    with_relations(with_state(root.by_pk(id), 'approved'), :talks)
      .map_to(Event)
      .one!
  end

  def latest(amount: 10)
    with_relations(with_state(order_by_ended_at, 'approved'), :talks)
      .map_to(Event)
      .limit(amount)
      .to_a
  end

  def order_by_ended_at
    root.order(:ended_at)
  end
end
