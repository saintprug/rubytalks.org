module Util
  module Web
    module Helpers
      module ValidateParams
        def validate_params(params)
          params = self.class.contract.new.call(params.to_h)
          params.failure? ? halt('invalid') : params.to_h
        end
      end
    end
  end
end
