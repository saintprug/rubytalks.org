# frozen_string_literal: true

module Entities
  class PaginatedCollection < ROM::Struct
    attribute :data, Types::Array
    attribute :meta, Types::Hash.default({})
  end
end
