# frozen_string_literal: true

module Web
  module Views
    module Events
      class Show
        include Web::View

        def title
          "Events | #{event.name}"
        end
      end
    end
  end
end
