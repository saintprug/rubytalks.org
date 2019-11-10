# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class ListForApprove
        include Operation
        include Import[
          talk_repo: 'repositories.talk',
          contract: 'domains.talks.contracts.list_for_approve'
        ]

        def call(input)
          input = yield validate(contract, input)

          talks = talk_repo.find_unpublished(
            limit: input[:limit],
            offset: input[:offset]
          )

          Success(talks)
        end
      end
    end
  end
end
