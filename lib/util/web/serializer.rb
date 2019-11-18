module Util
  module Web
    class Serializer < Representable::Decorator
      include Representable::JSON
    end
  end
end
