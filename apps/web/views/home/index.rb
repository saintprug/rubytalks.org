# frozen_string_literal: true

module Web
  module Views
    module Home
      class Index
        include Web::View

        def title
          'All Ruby talks in one place'
        end
      end
    end
  end
end
