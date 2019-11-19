# frozen_string_literal: true

module Util
  module Web
    module Serializers
      class Collection < Util::Web::Serializer
        property :data, exec_context: :decorator
        property :meta, exec_context: :decorator

        def initialize(result, with:)
          @with = with

          super(result)
        end

        def data
          @with.for_collection.new(represented.data).to_hash
        end

        def meta
          represented.meta
        end
      end
    end
  end
end
