module Kinopoisk
  class Search
    attr_accessor :query
 HEADERS = {'Referer' => 'http://www.kinopoisk.ru/',
            'User-Agent' => 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100723 openSUSE ROCKS! Firefox/3.6.8'} 
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
      links = document.search("//div[@class='element most_wanted']").search("p[@class='name']").search("a")
      links.reject! {|item| item.attributes['href'] !~ /\/film\// }
      links = links.map do |item|
        id = item['href'][/\d{3,}/]
        title = item.inner_html
        Kinopoisk::Movie.new id, title
      end
    end
    
    def self.query(query)
      begin
        url = URI.parse "http://s.kinopoisk.ru/index.php?first=no&kp_query=#{ URI.escape(query) }"
        request = Net::HTTP.new url.host, url.port
        response = request.get "#{url.path}?#{url.query}", HEADERS
        response.body.to_utf8
        
      rescue Net::HTTPError
        nil
      end
    end
  end
end
