require "iconv"

String.class_eval do
  def to_utf8
    Iconv.iconv('utf-8', 'windows-1251', self).join
  end
end
