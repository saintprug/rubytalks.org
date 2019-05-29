# frozen_string_literal: true

module Talks
  module Operations
    class List < Operation
      include Import[
        talk_repo: 'repositories.talk'
      ]

      def call(_params)
        talk_repo.latest
      end
    end
  end
end
