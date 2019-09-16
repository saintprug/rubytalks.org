# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.3'

gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'

gem 'pg'

gem 'sequel'
gem 'sequel_pg', require: 'sequel'

gem 'xml-sitemap'

# templates, preprocessors
gem 'hanami-bootstrap'
gem 'jquery-hanami'
gem 'sass'
gem 'slim'

# dry stuff
gem 'dry-monads', '~> 1.1.0'
gem 'dry-system', '~> 0.9.0'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'
gem 'dry-validation'

# logging
gem 'awesome_print'
gem 'semantic_logger'

# generate embed from url
gem 'ruby-oembed'

# pagination
gem 'hanami-pagination', github: 'davydovanton/hanami-pagination'

# YouTube client
gem 'yt', '~> 0.28.0'

# background jobs
gem 'hiredis'
gem 'sidekiq'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby

  # code style
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  gem 'database_cleaner'

  # fake data
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'hanami-fabrication'

  # debug
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'rspec'

  gem 'rspec-hanami'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

group :production do
  gem 'puma'
end
