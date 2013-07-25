# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'verbal'
  gem.summary = %Q{Library that makes difficult regular expressions easy!}
  gem.description = %Q{Verbal Expressions is a library that makes constructing difficult regular expressions simple and easy!}
  gem.authors = ['Ryan Endacott', 'Jim Lim']
  gem.email   = 'jim@jimjh.com'
  gem.homepage = 'http://github.com/jimjh/verbal'
  gem.platform = Gem::Platform::RUBY
  gem.license  = 'MIT'
  gem.has_rdoc = 'yard'
  gem.files.include 'LICENSE', 'VERSION', 'README.md', '.yardopts', 'Rakefile'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec
