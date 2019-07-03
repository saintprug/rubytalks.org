# frozen_string_literal: true

module Talks
  module Operations
    class ListForApprove < Operation
      include Import[
        talk_repo: 'repositories.talk'
      ]

      def call(_params)
        Success(talk_repo.for_approve)
      end
    end
  end
end
