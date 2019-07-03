# frozen_string_literal: true

class TalkRepository < Hanami::Repository
  associations do
    has_many :talks_speakers
    has_many :speakers, through: :talks_speakers
    belongs_to :event
  end

  # TODO: move state related stuff to generic module
  def latest(amount: 10)
    order_by_date
      .where(state: 'approved')
      .limit(amount)
      .to_a
  end

  def find_with_speakers(id)
    root
      .by_pk(id)
      .where(state: 'approved')
      .combine(:speakers)
      .map_to(Talk)
      .one
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

  def order_by_created_at
    root
      .order(:created_at)
  end
end
