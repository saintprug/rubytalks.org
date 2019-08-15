# frozen_string_literal: true

module Admin
  module Views
    class ApplicationLayout
      include Admin::Layout
      include Shared::Helpers::Flash
    end
  end
end
