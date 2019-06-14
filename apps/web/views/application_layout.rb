# frozen_string_literal: true

module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def full_name(speaker:)
        [speaker.first_name, speaker.last_name].join(' ')
      end
    end
  end
end
