# frozen_string_literal: true

Factory = ROM::Factory.configure do |config|
  config.rom = Hanami::Container[:rom]
end
