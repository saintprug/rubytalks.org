# frozen_string_literal: true

require 'simplecov'
require 'simplecov-json'
SimpleCov.start

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::JSONFormatter
]

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
