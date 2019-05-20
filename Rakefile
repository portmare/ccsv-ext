require "bundler/gem_tasks"
require "rake/testtask"
require 'rake/extensiontask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

gemspec = Gem::Specification.load('ccsv_ext.gemspec')
Rake::ExtensionTask.new do |ext|
  ext.name = 'ccsv_ext'
  ext.source_pattern = "*.{c,h}"
  ext.ext_dir = 'ext/ccsv_ext'
  ext.lib_dir = 'lib/ccsv_ext'
  ext.gem_spec = gemspec
end

task :default => [:compile, :test]
