# frozen_string_literal: true

class SpeakerRepository < Hanami::Repository
  associations do
    has_many :talks, through: :talks_speakers
  end

  def find_by_name(name)
    speakers.where(name: name).one
  end
end
