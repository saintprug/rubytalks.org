# frozen_string_literal: true

module Web
  module Views
    module Speakers
      class Show
        include Web::View

        def title
          "Speakers | #{full_name(speaker: speaker)}"
        end
      end
    end
  end
end
