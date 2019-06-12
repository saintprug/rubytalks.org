# frozen_string_literal: true

Fabrication.configure do |config|
  config.path_prefix = Hanami.root
  config.fabricator_path = 'spec/support/fabricators'
end
