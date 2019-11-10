# frozen_string_literal: true

require 'hanami/container'
require_relative './container_ext/file_registration'

Hanami::Container.load_paths!('lib')

Hanami::Container.extend(ContainerExt::FileRegistration)

Hanami::Container.configure do |config|
  config.auto_register = %w[
    lib/repositories
    lib/domains/*/contracts
    lib/domains/*/operations
    lib/domains/*/util
    lib/util/*
  ]
end

Hanami::Container.register_file! 'util/validator'

require_relative 'import'
