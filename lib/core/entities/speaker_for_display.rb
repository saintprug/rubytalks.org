# frozen_string_literal: true

class SpeakerForDisplay < Hanami::Entity
  def full_name
    [first_name, last_name].join(' ')
  end
end
