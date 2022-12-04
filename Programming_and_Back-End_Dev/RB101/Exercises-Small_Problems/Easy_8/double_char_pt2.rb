def double_consonants(str)
  str.gsub(/([^aeiouAEIOU\W\d])/, '\1\1')
end

puts double_consonants('String') == "SSttrrinngg"
puts double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
puts double_consonants("July 4th") == "JJullyy 4tthh"
puts double_consonants('') == ""
