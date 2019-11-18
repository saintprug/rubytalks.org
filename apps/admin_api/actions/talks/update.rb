# frozen_string_literal: true

module AdminApi
  module Actions
    module Talks
      class Update < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include Import[
          update: 'domains.talks.operations.update'
        ]

        params do
          required(:id).filled(:integer)
          optional(:title).filled(:str?)
          optional(:description).filled(:str?)
          optional(:talked_at).filled(:str?) # TODO: check iso8601 type
          optional(:link).filled(:str?)
        end

        # TODO: handle failure
        def handle(request, response)
          input = validate_params(request.params)
          result = update.call(input)

          respond_with_success(response, result.value!, with: Serializers::Talk)
        end
      end
    end
  end
end
