require 'rake/testtask'

desc "Run all the tests"
task :default => [:test]

lib_files = FileList.new do |fl|
  fl.include "lib"
  fl.include "test/lib"
end

test_files = FileList.new do |fl|
  fl.include "test/**/*_test.rb"
  fl.exclude "test/test_helper.rb"
  fl.exclude "test/lib/**/*.rb"
end

desc 'Run all tests'
Rake::TestTask.new(:test) do |t|
  t.libs = lib_files
  t.test_files = test_files
  t.verbose = true
end
