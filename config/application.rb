# frozen_string_literal: true

require 'hanami/middleware/body_parser'
require_relative '../lib/operation'
require_relative '../lib/types'
require_relative '../system/container'

require_relative '../apps/admin_api/action'
require_relative '../apps/user_api/action'

require_relative '../system/middleware/request_logger'

module RubyTalks
  class Application < Hanami::Application
    config.default_request_format = :json
    config.default_response_format = :json

    config.logger = Hanami::Container[:my_logger]
    #config.middleware.use Middleware::RequestLogger
    config.middleware.use Hanami::Middleware::BodyParser, :json
  end
end
