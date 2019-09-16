# frozen_string_literal: true

require 'rake'
require 'hanami/rake_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  warn 'Could not start RSpec'
end

Rake::Task['db:migrate'].clear
Dir.glob('lib/tasks/*.rake').each { |rake_task| load rake_task }
