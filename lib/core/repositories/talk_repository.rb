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

  def find_with_speakers(id)
    with_state(with_relations(root.by_pk(id), :speakers), 'approved')
      .map_to(Talk)
      .one!
  end

  def for_approve(amount: 10)
    order_by_created_at
      .where(state: 'unpublished')
      .combine(:speakers)
      .combine(:event)
      .map_to(Talk)
      .limit(amount)
      .to_a
  end

  private

  def order_by_date
    talks
      .order(:talked_at)
  end

  private

  def order_by_date(relation)
    relation.order { talked_at.desc }
  end
end
