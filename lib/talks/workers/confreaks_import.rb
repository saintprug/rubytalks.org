# frozen_string_literal: true

module Talks
  module Workers
    class ConfreaksImport
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[
                :logger,
                :rollbar,
                operation: 'talks.operations.importer.confreaks'
              ]

      def perform
        result = operation.call

        case result
        when Success
          logger.info("#{result.value![:amount]} talks successfully imported")
        when Failure
          puts 'error'
        end
      end
    end
  end
end
