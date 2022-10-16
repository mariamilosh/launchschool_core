CAPS = ('A'..'Z')

def swapcase(str)
  str.chars.map do |c|
    CAPS.include?(c) ? c.downcase : c.upcase
  end.join
end

puts swapcase('CamelCase') == 'cAMELcASE'
puts swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'
