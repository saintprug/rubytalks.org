# frozen_string_literal: true

module Core
  module Helpers
    module SpeakerHelper
      def full_name(speaker)
        [speaker.first_name, speaker.last_name].join(' ')
      end
    end
  end
end
