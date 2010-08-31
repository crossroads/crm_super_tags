require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

desc 'Default: run specs.'
task :default => :spec

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Run the specs for bamboo (requires ci_reporter)'
Spec::Rake::SpecTask.new(:bamboo) do |t|
  t.spec_opts = ["--require #{Gem.path.last}/gems/ci_reporter-1.6.2/lib/ci/reporter/rake/rspec_loader --format CI::Reporter::RSpec"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end
