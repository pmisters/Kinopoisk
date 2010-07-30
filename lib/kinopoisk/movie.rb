module Kinopoisk
  class Movie
    attr_accessor :id, :url, :title
    
    def initialize(movie_id, title = nil)
      @id = movie_id
      @url = "http://www.kinopoisk.ru/level/1/film/#{movie_id}/"
      @title = title if title
    end
    
    def author
      document.search("//td[text()='сценарий'] ~ a").map do |link|
        link.inner_html.strip
      end
    end
    
    def cast_members
      skip = false
      document.search("//td[@class='actor_list']/span/a").map do |link|
        skip = true if link.inner_html.strip == '...'
        link.inner_html.strip unless skip
      end.compact
    end
    
    def country
      document.search("//table[@class='info']/tr/td/a[@href*=/m_act%5Bcountry%5D/]").inner_html rescue nil
    end
    
    def description
      text = document.search("//td[@class='news']/span[@class='_reachbanner_']").inner_html
      text.strip.gsub '&nbsp;', ' '
    end
    alias :plot :description
    
    def director
      document.search("//td[text()='режиссер'] ~ a").map do |link|
        link.inner_html.strip
      end
    end
    
    def genres
      result = document.search("//td[text()='жанр'] ~ a").map do |link|
        link.inner_html.strip
      end
      result.reject{ |g| g == '...'}
    end
    
    def poster
      images = document.search("//img[@src*=/images/']").map do |item| 
        "http://www.kinopoisk.ru#{item.attributes['src']}"
      end
      images.reject{ |item| item !~ /images\/film\// }.first
    end
    
    def producer
      document.search("//td[text()='продюсер'] ~ a").map do |link|
        link.inner_html.strip
      end
    end
    
    def rating
      result = document.search("//div[@class='block_2']/div/a[@class='continue']").inner_html
      result.gsub /<[\s\S]+$/, ''
    end
    
    def length
      document.search("//td[@id='runtime']").inner_html.strip.to_i
    end
    
    def year
      document.search("//table[@class='info']/tr/td/a[@href*=/m_act%5Byear%5D/]").inner_html.to_i rescue nil
    end
    
    private
    
    def document
      @document ||= Hpricot Kinopoisk::Movie.find_by_id(@id), :fixup_tags => true
    end
    
    def self.find_by_id(movie_id)
      begin
        url = URI.parse "http://www.kinopoisk.ru/level/1/film/#{movie_id}/"
        request = Net::HTTP.new url.host, url.port
        response = request.get url.path, {'Referer' => 'http://www.kinopoisk.ru/',
                                          'User-Agent' => 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100723 Ubuntu/10.04 (lucid) Firefox/3.6.8'}
        response.body.to_utf8
        
      rescue Net::HTTPError
        nil
      end
    end
  end
end
