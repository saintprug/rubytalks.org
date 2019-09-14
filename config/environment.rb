# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../system/import'
require_relative '../apps/web/application'
require_relative '../apps/admin/application'

Hanami.configure do
  mount Admin::Application, at: '/admin'
  mount Web::Application, at: '/'

  model do
    adapter :sql, ENV.fetch('DATABASE_URL')

    migrations 'db/migrations'
    schema 'db/schema.sql'

    # Use connection_validator sequel plugin for setup how often we need to check are connections
    # valid in connection pool or not. If connections invalid (DB instance was restarted) we will
    # reopen all connections again. In our case we will do it every 30 second or
    # `ENV['DATABASE_CONNECTION_VALIDATION_TIMEOUT']` seconds.
    gateway do |g|
      g.connection.extension(:connection_validator)
      g.connection.pool.connection_validation_timeout = ENV['DATABASE_CONNECTION_VALIDATION_TIMEOUT'] || 30 # seconds
    end
  end
  logger level: :debug
  mailer do
    root 'lib/core/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :production do
    # mailer do
    #   delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    # end
  end
end
