module Kinopoisk
  class Search
    attr_accessor :query
    
    def initialize(query)
      @query = query
    end
    
    def movies
      @movies ||= parse_movies
    end
    
    private
    
    def document
      @document ||= Hpricot Kinopoisk::Search.query(@query), :fixup_tags => true
    end

    def parse_movies
      links = document.search("//a[@class='all']")
      links.reject! {|item| item.attributes['href'] !~ /\/film\// }
      links = links.map do |item|
        id = item['href'][/\d{3,}/]
        title = item.inner_html
        Kinopoisk::Movie.new id, title
      end
    end
    
    def self.query(query)
      begin
        url = URI.parse "http://www.kinopoisk.ru/index.php?first=no&kp_query=#{ URI.escape(query) }"
        request = Net::HTTP.new url.host, url.port
        response = request.get "#{url.path}?#{url.query}"
        response.body.to_utf8
        
      rescue Net::HTTPError
        nil
      end
    end
  end
end
