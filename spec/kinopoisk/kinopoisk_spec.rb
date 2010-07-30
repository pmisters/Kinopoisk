require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe :Kinopoisk do
  it 'should report the correct version' do
    version = File.open(File.join(File.dirname(__FILE__), '..', '..', 'VERSION'), 'r') do |f|
      f.read.strip
    end
    Kinopoisk::VERSION.should == version
  end
end
