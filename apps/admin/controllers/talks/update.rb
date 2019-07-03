# frozen_string_literal: true

module Admin
  module Controllers
    module Talks
      class Update
        include Admin::Action
        include Dry::Monads::Result::Mixin
        include Import[
                  operation: 'talks.operations.'
                ]

        def call(params)
          result = operation.call(params)
          if result.success?
            flash[:success] = 'Talk has been declined'
          else
            flash[:error] = 'Talk has not been declined'
          end
          redirect_to routes.root
        end
      end
    end
  end
end
