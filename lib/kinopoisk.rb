$: << File.dirname(__FILE__) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "rubygems"
require "hpricot"
require "uri"
require "net/http"

require "extendings"
require "kinopoisk/movie"
require "kinopoisk/search"

module Kinopoisk
  VERSION = File.open(File.expand_path(File.dirname(__FILE__) + '/../VERSION'), 'r') {|f| f.read.strip }
end
