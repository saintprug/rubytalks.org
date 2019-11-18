# frozen_string_literal: true

module Domains
  module Speakers
    module Util
      class SlugGenerator
        def generate(first_name:, last_name:)
          [first_name, last_name].compact.join('-').downcase
        end
      end
    end
  end
end
