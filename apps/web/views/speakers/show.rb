# frozen_string_literal: true

module Web
  module Views
    module Speakers
      class Show
        include Web::View

        def title
          "Speakers | #{speaker.full_name}"
        end
      end
    end
  end
end
