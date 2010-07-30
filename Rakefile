require "rubygems"
require "rake"
require "echoe"

load File.expand_path(File.dirname(__FILE__) + '/tasks/fixtures.rake')

require "rake/rdoctask"
Rake::RDocTask.new do |rdoc|
  if File.exists? 'VERSION'
    version = File.read 'VERSION'
  else
    version = ''
  end
  
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "kinopoisk #{version}"
  rdoc.rdoc_files.include 'README*'
  rdoc.rdoc_files.include 'lib/**/*.rb'
end

Echoe.new('kinopoisk', File.read('VERSION').strip) do |p|
  p.author = 'Pavel Musolin'
  p.email = 'pavel@harizma.lv'
  p.description = 'Easely access the publicly available information on Kinopoisk.ru'
  p.files = FileList["{lib,spec}/**/*.rb"].to_a
  p.url = 'http://github.com/pmisters/Kinopoisk'
  p.has_rdoc = true
  p.platform = Gem::Platform::RUBY
  p.dependencies = ['hpricot >=0.8.1']
end
