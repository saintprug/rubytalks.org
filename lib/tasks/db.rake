require 'bundler/setup'
require 'sequel'
require 'hanami/logger'

namespace :db do
  task :connect do
    require 'hanami/setup' # Load dotenv

    Sequel.extension(:migration)

    DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
    DB.logger = Hanami::Logger.new('rubytalks', stream: STDOUT)
  end

  desc 'Perform migration up to latest migration available'
  task migrate: :connect do
    Sequel::Migrator.apply(DB, 'db/migrations')

    if ENV['HANAMI_ENV'] == 'development'
      Rake::Task['db:schema:dump'].execute
    end
  end

  desc 'Perform migration down to one version'
  task rollback: :connect do
    target = DB[:schema_migrations].offset(1).order(:filename).last[:filename].match(/\A\d+/)[0]
    Sequel::Migrator.apply(DB, 'db/migrations', Integer(target))

    if ENV['HANAMI_ENV'] == 'development'
      Rake::Task['db:schema:dump'].execute
    end
  end

  namespace :schema do
    desc 'Dumps db/schema.rb file'
    task dump: :connect do
      DB.extension(:schema_dumper)
      DB.loggers = []

      lines = DB.dump_schema_migration.lines.map do |l|
        l.gsub(/\A\s*\z/, "\n").gsub(/:(\w+)=>/, '\1: ')
      end
      schema = lines.join
      File.write('db/schema.rb', schema)
    end
  end
end
