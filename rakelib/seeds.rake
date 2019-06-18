# frozen_string_literal: true

require_relative 'seeder'

desc 'Populates db with records'
task seeds: :environment do
  Seeder.new.call
end
