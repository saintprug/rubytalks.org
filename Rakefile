# frozen_string_literal: true

require 'rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  warn 'Could not start RSpec'
end

Dir.glob('lib/tasks/*.rake').each { |rake_task| load rake_task }
