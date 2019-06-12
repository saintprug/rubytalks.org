# frozen_string_literal: true

class SpeakerRepository < Hanami::Repository
  associations do
    has_many :talks_speakers
    has_many :talks, through: :talks_speakers
  end

  def find_by_name(first_name: nil, last_name: nil)
    root
      .where(first_name: first_name, last_name: last_name)
      .one
  end

  def order_by_last_name(order: :asc)
    root
      .order { [last_name.send(order), first_name] }
      .to_a
  end

  def find_with_talks(id:)
    root.by_pk(id).combine(:talks).map_to(Speaker).one
  end

  def all
    root.map_to(Speaker)
  end
end
