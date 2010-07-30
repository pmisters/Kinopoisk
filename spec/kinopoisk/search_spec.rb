require File.dirname(__FILE__) + '/../spec_helper'

describe 'Kinopoisk::Search' do
  before(:each) do
    @search = Kinopoisk::Search.new 'Туман (2010)'
  end

  it 'should remember the query' do
    @search.query.should == 'Туман (2010)'
  end
  
  it 'should find 6 results' do
    @search.movies.size.should == 6
  end
  
  it 'should return only Kinopoisk::Movie objects' do
    @search.movies.each{ |item| item.should be_a(Kinopoisk::Movie) }
  end
  
  it 'should not return items without title' do
    @search.movies.each{ |item| item.title.should_not be_empty }
  end
end
