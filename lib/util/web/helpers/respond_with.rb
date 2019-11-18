module Util
  module Web
    module Helpers
      module RespondWith
        def respond_with(result, serializer, status)
          if result.success?
            respond_with_success(result.value!, serializer, status)
          else
            respond_with_failure(result.failure, status)
          end
        end

        def respond_with_collection(response, result, serializer, status: 200)
          if result.success?
            respond_with_success(
              response,
              result.value!,
              with: serializer,
              base: Util::Web::Serializers::Collection,
              status: status
            )
          else
            respond_with_failure(result.failure, status)
          end
        end

        def respond_with_success(response, value, with:, base: Util::Web::Serializers::Success, status: 200)
          response.status = status
          response.body = base.new(value, with: with).to_json
        end
      end
    end
  end
end
