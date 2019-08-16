# frozen_string_literal: true

unless Hanami.env?(:production)
  Fabrication.configure do |config|
    config.path_prefix = Hanami.root
    config.fabricator_path = 'spec/support/fabricators'
  end
end
