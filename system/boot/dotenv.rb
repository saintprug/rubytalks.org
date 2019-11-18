# frozen_string_literal: true

Hanami::Container.boot(:dotenv) do |app|
  start do
    Dotenv.load(app.root.join(".env.#{ENV['HANAMI_ENV']}")) if defined?(Dotenv)
  end
end
