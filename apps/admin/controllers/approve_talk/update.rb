# frozen_string_literal: true

module Admin
  module Controllers
    module ApproveTalk
      class Update
        include Admin::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'talks.operations.approve'
        ]

        def call(params)
          result = operation.call(params[:id])
          if result.success?
            flash[:success] = 'Talk has been approved'
          else
            flash[:error] = 'Talk has not been approved'
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
