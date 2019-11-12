Hanami::Container.boot(:rom) do |app|
  init do
    require 'dotenv'
  end

  start do
    configuration = ROM::Configuration.new(:sql, ENV.fetch('DATABASE_URL'))
    configuration.auto_registration(app.root.join('lib/persistence'))

    container = ROM.container(configuration)

    register(:rom, container)
  end
end
