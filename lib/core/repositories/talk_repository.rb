# frozen_string_literal: true

require_relative 'shared/base'
require_relative 'shared/stateable'

class TalkRepository < Hanami::Repository
  include Base
  include Stateable

  associations do
    has_many :talks_speakers
    has_many :speakers, through: :talks_speakers
    belongs_to :event
  end

  def latest(amount: 10)
    order_by_date(with_state(root, 'approved'))
      .limit(amount)
      .map_to(Talk)
      .to_a
  end

  # with state `unpublished` and `declined`
  def find_unapproved(id)
    without_state(with_relations(root.by_pk(id), :speakers, :event), 'approved')
      .map_to(Talk)
      .one!
  end

  def find_approved_with_speakers_and_event(id)
    with_state(with_relations(root.by_pk(id), :speakers, :event), 'approved')
      .map_to(Talk)
      .one!
  end

  def for_approve(amount: 10)
    with_relations(with_state(order_by_created_at(root), 'unpublished'), :speakers, :event)
      .limit(amount)
      .map_to(Talk)
      .to_a
  end

  def find_with_speakers_and_event(id)
    with_relations(root.by_pk(id), :speakers, :event)
      .map_to(Talk)
      .one!
  end

  private

  def order_by_date(relation)
    relation.order { talked_at.desc }
  end
end
