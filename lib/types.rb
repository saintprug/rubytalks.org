# frozen_string_literal: true

module Core
  module Types
    include Dry::Types.module

    States = String.constructor(proc { |value| value.to_s.downcase })
                   .default('unpublished')
                   .enum('unpublished', 'approved', 'declined')
  end
end
