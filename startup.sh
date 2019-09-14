bundle exec hanami db migrate
bundle exec hanami assets precompile
bundle exec hanami server --port $PORT
