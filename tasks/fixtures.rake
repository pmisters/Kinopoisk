namespace :fixtures do
  desc 'Refresh spec fixtures with fresh data from Kinopoisk.ru'
  task :refresh do
    require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')
    
    KINOPOISK_SAMPLES.each do |url, response|
      output = File.expand_path File.dirname(__FILE__) + "/../spec/fixtures/#{response}"
      `wget --referer="http://www.kinopoisk.ru/" --output-document="#{output}" --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100723 Ubuntu/10.04 (lucid) Firefox/3.6.8" --save-headers "#{url}"`
    end
  end
end
