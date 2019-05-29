# frozen_string_literal: true

module Web
  module Views
    module Talks
      class Show
        include Web::View

        def title
          talk.title
        end
      end
    end
  end
end
