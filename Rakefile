require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

task default: :build

task build: [:clean, :prepare, :rubocop, :cucumber]

task :clean do
  FileUtils.rm_rf 'build'
end

task :prepare do
  FileUtils.mkdir_p('build')
end

Rubocop::RakeTask.new

Cucumber::Rake::Task.new(:cucumber)
