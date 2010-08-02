module Kinopoisk
  class Movie
    attr_accessor :id, :url, :title
    
    HEADERS = {'Referer' => 'http://www.kinopoisk.ru/',
               'User-Agent' => 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100723 Ubuntu/10.04 (lucid) Firefox/3.6.8'}

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
      text = text.gsub /<br[\s\/]*>/, "\n"
      Hpricot(text).inner_text#.strip.gsub '&nbsp;', ' '
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
    
    def length
      document.search("//td[@id='runtime']").inner_html.strip.to_i
    end
    
    def poster
      begin
        cover_page.search("//table[@id='main_table']/tr/td/a/img").first.attributes['src']
      rescue
        nil
      end
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
    
    def thumbnail
      images = document.search("//img[@src*=/images/']").map do |item| 
        "http://www.kinopoisk.ru#{item.attributes['src']}"
      end
      images.reject{ |item| item !~ /images\/film\// }.first
    end

    def year
      document.search("//table[@class='info']/tr/td/a[@href*=/m_act%5Byear%5D/]").inner_html.to_i rescue nil
    end
    
    private
    
    def cover_page
      return @cover_page unless @cover_page.nil?
      
      begin
        url = URI.parse "http://www.kinopoisk.ru#{cover_page_url}"
        request = Net::HTTP.new url.host, url.port
        response = request.get url.path, HEADERS
        @cover_page = Hpricot response.body.to_utf8, :fixup_tags => true
        
      rescue Net::HTTPError
        nil
      end
    end
    
    def cover_page_url
      begin
        url = URI.parse "http://www.kinopoisk.ru/level/17/film/#{@id}/adv_type/cover/"
        request = Net::HTTP.new url.host, url.port
        response = request.get url.path, HEADERS
        
        cover_list_document = Hpricot response.body.to_utf8, :fixup_tags => true
        cover_list_document.search("//tr[@class='last']/td/a").first.attributes['href']
        
      rescue Net::HTTPError
        nil
      end
    end
    
    def document
      @document ||= Hpricot Kinopoisk::Movie.find_by_id(@id), :fixup_tags => true
    end
    
    def self.find_by_id(movie_id)
      begin
        url = URI.parse "http://www.kinopoisk.ru/level/1/film/#{movie_id}/"
        request = Net::HTTP.new url.host, url.port
        response = request.get url.path, HEADERS
        response.body.to_utf8
        
      rescue Net::HTTPError
        nil
      end
    end
  end
end
