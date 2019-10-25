# frozen_string_literal: true

require 'hanami/container'

Hanami::Container.load_paths!('lib')

Hanami::Container.configure do |config|
  config.auto_register = %w[
    lib/repositories
    lib/domains/*/operations
    lib/domains/*/util
  ]
end

require_relative 'import'
