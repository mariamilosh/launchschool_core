def palindrome?(phrase)
  phrase_arr = phrase.split("")
  reverse_phrase = phrase_arr.reverse.join("")
  phrase == reverse_phrase
end

def palindrome_arr?(arr)
  arr == arr.reverse
end

# puts palindrome?('madam') == true
# puts palindrome?('Madam') == false          # (case matters)
# puts palindrome?("madam i'm adam") == false # (all characters matter)
# puts palindrome?('356653') == true

puts palindrome_arr?(['m', 'a', 'd', 'a', 'm']) == true
# puts palindrome_arr?('Madam') == false          # (case matters)
# puts palindrome_arr?("madam i'm adam") == false # (all characters matter)
# puts palindrome_arr?('356653') == true
