begin
  require "spec"
rescue LoadError
  require "rubygems"
  gem 'rspec'
  require "spec"
end

$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'kinopoisk'
require "pp"

def read_fixtures(path)
  File.read File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', path))
end

KINOPOISK_SAMPLES = {
  'http://www.kinopoisk.ru/level/1/film/273302/' => '273302',
  'http://www.kinopoisk.ru/level/1/film/84991/' => '84991',
  'http://www.kinopoisk.ru/index.php?first=no&kp_query=%D0%A2%D1%83%D0%BC%D0%B0%D0%BD%20(2010)' => 'search_tuman_2010'
}

unless ENV['LIVE_TEST']
  begin
    require "rubygems"
    require "fakeweb"
    
    FakeWeb.allow_net_connect = false
    KINOPOISK_SAMPLES.each do |url, response|
      FakeWeb.register_uri :get, url, :response => read_fixtures(response)
    end
    
  rescue LoadError
    puts 'Could not load FakeWeb, this test will hit Kinopoisk.ru'
    puts 'You can run `gem install fakeweb` to stub out the responses.'
  end
end
