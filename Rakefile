require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :build do
  puts `gem build reapal.gemspec`
end

task :push do
  puts `gem push reapal-#{Reapal::VERSION}.gem`
end

task :publish => [:build, :push]
