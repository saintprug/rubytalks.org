# frozen_string_literal: true

module Web
  module Views
    module Talks
      class New
        include Web::View

        def title
          'Add Talk'
        end

        def form
          Form.new(:talk, routes.talks_path, talk: { speakers: [Speaker.new] })
        end

        def submit_label
          'Create talk'
        end
      end
    end
  end
end
