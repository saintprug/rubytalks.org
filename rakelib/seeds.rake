desc 'Populates db with records'
task :seeds do
  Seeder.new.call
end
