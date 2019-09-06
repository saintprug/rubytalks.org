# frozen_string_literal: true

module Web
  module Views
    class ApplicationLayout
      include Web::Layout
      include Shared::Helpers::Flash
    end
  end
end
