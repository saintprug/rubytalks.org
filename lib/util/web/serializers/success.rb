module Util
  module Web
    module Serializers
      class Success < Util::Web::Serializer
        property :data, exec_context: :decorator

        def initialize(result, with:)
          @with = with

          super(result)
        end

        def data
          @with.new(represented).to_hash
        end
      end
    end
  end
end
