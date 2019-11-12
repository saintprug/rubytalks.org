# frozen_string_literal: true

module Domains
  module Talks
    module Operations
      class List
        include Operation
        include Import[
          talk_repo: 'repositories.talk'
        ]

        def call
          talks = talk_repo.all

          Success(talks)
        end
      end
    end
  end
end
