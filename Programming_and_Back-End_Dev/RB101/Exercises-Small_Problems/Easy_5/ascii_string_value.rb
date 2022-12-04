def ascii_value(str)
  str.chars.inject(0) { |sum, c| sum += c.ord }
end

puts ascii_value('Four score') == 984
puts ascii_value('Launch School') == 1251
puts ascii_value('a') == 97
puts ascii_value('') == 0

char = 'c'
puts char.ord.chr == char
char = 'cat'
puts char.ord.chr == char
# trying with a longer string, only the first character of the
#   string is returned.
