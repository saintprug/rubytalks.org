# frozen_string_literal: true

class TalkRepository < Hanami::Repository
  associations do
    has_many :talks_speakers
    has_many :speakers, through: :talks_speakers
    belongs_to :event
  end

  def latest(amount: 10)
    order_by_date
      .limit(amount)
      .to_a
  end

  def find_with_speakers(id)
    root
      .by_pk(id)
      .combine(:speakers)
      .map_to(Talk)
      .one
  end

  private

  def order_by_date
    talks
      .order(:talked_at)
  end
end
