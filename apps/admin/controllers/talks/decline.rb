# frozen_string_literal: true

module Admin
  module Controllers
    module Talks
      class Decline < Admin::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'talks.operations.decline'
        ]

        def call(params)
          result = operation.call(params[:id])
          case result
          when Success
            flash[:success] = 'Talk has been declined'
          when Failure
            # TODO: log to rollbar/sentry
            flash[:error] = 'Something wrong. Talk has not been declined'
          end
          redirect_to routes.root_url
        end

        private

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
