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

begin
  require 'metric_fu'
  MetricFu::Configuration.run do |config|
    #define which metrics you want to use
    config.metrics  = [:churn, :saikuro, :flog, :flay, :reek, :roodi, :rcov]
    config.graphs   = [ ] #[:flog, :flay, :reek, :roodi, :rcov]
    config.reek     = { :dirs_to_reek => ['lib']  }
    config.rcov     = { :test_files => test_files.to_a,
                        :rcov_opts => ["--sort coverage", 
                                       "--no-html", 
                                       "--text-coverage",
                                       "--no-color",
                                       "--profile",
                                       "--include lib/",
                                       "--include-file ^lib/.*\\.rb",
                                       "--exclude /gems/,/Library/,spec"] }
  end
rescue LoadError
  task 'coverage:all' do
    puts "Metric-Fu is not installed. Try [sudo] gem install jscruggs-metric_fu"
  end
end

namespace :metrics do

  desc "Clean up after the metrics"
  task :clean do
    rm_r 'tmp/metric_fu' if File.directory?('tmp/metric_fu')
  end
  
end

desc "Generate RDoc documentation"
task :doc => ['doc:generate']

begin
  require 'yard'
  require 'yard/rake/yardoc_task'

  namespace :doc do
  
    doc_dir = './doc/rdoc'
    readme  = './README.rdoc'
  
    YARD::Rake::YardocTask.new(:generate) do |yt|
      yt.files   = ['lib/**/*.rb', readme]
      yt.options = ['--output-dir', doc_dir, '--readme', readme]
    end
  
    desc "Remove generated documenation"
    task :clean do
      rm_r doc_dir if File.exists?(doc_dir)
    end
  
  end
rescue LoadError
  namespace :doc do
    task :generate do
      puts "YARD is not installed. Try [sudo] gem install yard"
    end
    task :clean => ['doc:generate']
  end
end
