# frozen_string_literal: true

require_relative './container'

module AdminApi
  AppImport = AdminApi::Container.injector
end

AdminApi::Container.finalize!
