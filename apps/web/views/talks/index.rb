# frozen_string_literal: true

module Web
  module Views
    module Talks
      class Index
        include Web::View
        include Shared::Helpers::Pagination

        def title
          'Talks'
        end
      end
    end
  end
end
