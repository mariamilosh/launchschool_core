def short_long_short(str1, str2)
  if str1.size > str2.size
    long_str = str1
    short_str = str2
  else
    long_str = str2
    short_str = str1
  end
  short_str + long_str + short_str
end

puts short_long_short('abc', 'defgh') == "abcdefghabc"
puts short_long_short('abcde', 'fgh') == "fghabcdefgh"
puts short_long_short('', 'xyz') == "xyz"
