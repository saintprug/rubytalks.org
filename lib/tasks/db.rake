# frozen_string_literal: true

require 'rom/sql/rake_task'

require 'bundler/setup'
require 'hanami'

Bundler.require(:default, :development, :test)

require_relative '../../system/container'

Hanami::Container.start(:dotenv)

namespace :db do
  task :setup do
    configuration = ROM::Configuration.new(:sql, ENV.fetch('DATABASE_URL'))
    container = ROM.container(configuration)

    ROM::SQL::RakeSupport.env = container
  end
end
