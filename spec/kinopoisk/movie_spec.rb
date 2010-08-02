require File.dirname(__FILE__) + '/../spec_helper'

describe 'Kinopoisk::Movie' do
  before(:each) do
    @movie = Kinopoisk::Movie.new '273302'
  end
  
  it 'should return the right url for movie' do
    @movie.url.should == 'http://www.kinopoisk.ru/level/1/film/273302/'
  end
  
  it 'should find the movie year' do
    @movie.year.should == 2007
  end
  
  it 'should find the country' do
    @movie.country.should == 'США'
  end
  
  it 'should find the directors' do
    @movie.director.should be_a(Array)
    @movie.director.should == ['Фрэнк Дарабонт']
  end
  
  it 'should find the authors' do
    @movie.author.should be_a(Array)
    @movie.author.should == ['Фрэнк Дарабонт', 'Стивен Кинг']
  end
  
  it 'should find the producer' do
    @movie.producer.should be_a(Array)
    @movie.producer.should == ['Фрэнк Дарабонт', 'Анна Гардуно', 'Лиз Глоцер', '...']
  end
  
  it 'should find genres' do
    @movie.genres.should be_a(Array)
    @movie.genres.should == ['ужасы', 'фантастика', 'триллер', 'драма']
  end
  
  it 'should find the movie length in minutes' do
    @movie.length.should == 120
  end
  
  it 'should find the description' do
    @movie.description.should == 'Маленький городок накрывает сверхъестественный туман, отрезая людей от внешнего мира. Группе героев, оказавшихся в этот момент в супермаркете, приходится вступить в неравный бой с обитающими в тумане монстрами.'
  end
  
  it '#plot is alias for #description' do
    @movie.plot.should == 'Маленький городок накрывает сверхъестественный туман, отрезая людей от внешнего мира. Группе героев, оказавшихся в этот момент в супермаркете, приходится вступить в неравный бой с обитающими в тумане монстрами.'
  end
  
  it 'should return description without html tags' do
    movie = Kinopoisk::Movie.new '8880'
    movie.plot.should == "Действие происходит спустя девять лет после событий предыдущей картины. Космический корабль «Алексей Леонов» с советско-американским экипажем на борту отправляется на Юпитер, чтобы разгадать тайну оставленного на орбите корабля-первопроходца «Дискавери».\n\nДля этого командиру и членам звездного экипажа предстоит вновь активировать выведенный из строя компьютерный мозг HAL-9000, который явился одной из причин провала первой экспедиции."
  end
  
  it 'should find the poster' do
    @movie.poster.should == 'http://www.kinopoisk.ru/images/film/273302.jpg'
  end
  
  it 'should find the rating' do
    @movie.rating.should == '7.651'
  end
  
  it 'should find all cast members' do
    @movie.cast_members.should == ['Томас Джейн', 'Марша Гэй Харден', 'Лори Холден', 
                                   'Андре Брогер', 'Тоби Джонс', 'Уильям Сэдлер', 
                                   'Джеффри ДеМун', 'Фрэнсис Стернхаген', 'Натан Гэмбл',
                                   'Алекса Давалос']
  end
end
