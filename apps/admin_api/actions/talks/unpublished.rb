# frozen_string_literal: true

module AdminApi
  module Actions
    module Talks
      class Unpublished < AdminApi::Action
        include Dry::Monads::Result::Mixin
        include AppImport[
          talks: 'admin_api.services.talks'
        ]

        params do
          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def handle(request, response)
          input = validate_params(request.params)
          result = talks.unpublished(input)

          respond_with_collection(response, result, Serializers::Talk)
        end
      end
    end
  end
end
