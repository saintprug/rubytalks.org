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
  end
  logger level: :debug
  mailer do
    root 'lib/core/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :production do
    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
