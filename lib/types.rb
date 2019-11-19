# frozen_string_literal: true

module Types
  include Dry.Types()

  States = String.constructor(proc { |value| value.to_s.downcase })
                 .default('unpublished')
                 .enum('unpublished', 'approved', 'declined')
end
