Hanami::Container.boot(:rom) do |app|
  init do
    require 'dotenv'
  end

  start do
    container = ROM.container(:sql, ENV.fetch('DATABASE_URL')) do |config|
      config.auto_registration(app.root.join('lib/persistence'))
      config.plugin(:sql, relations: :pagination)
    end

    register(:rom, container)
  end
end
