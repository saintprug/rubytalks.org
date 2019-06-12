# frozen_string_literal: true

desc 'Populates db with records'
task seeds: :environment do
  Utils::Seeder.new.call
end
