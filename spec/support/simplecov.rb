# frozen_string_literal: true

# Set `COVERAGE` only on CI or manually if you want to see the report
if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/config/'
    add_filter '/db/'
    add_filter '/system/'

    %w[web].each do |app|
      add_filter "/apps/#{app}/application"
      add_filter "/apps/#{app}/templates"
      add_filter "/apps/#{app}/config"
      add_filter "/apps/#{app}/asserts"
    end
  end
end
