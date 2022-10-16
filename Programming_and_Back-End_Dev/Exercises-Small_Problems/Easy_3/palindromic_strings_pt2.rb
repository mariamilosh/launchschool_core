def real_palindrome?(phrase)
  phrase_arr = phrase.split('')
  alpha_num = phrase_arr.select do |letter|
    (48..57).include?(letter.ord) || (65..90).include?(letter.ord) ||
      (97..122).include?(letter.ord)
  end.join('').downcase
  alpha_num == alpha_num.reverse
end

def palindrome?(phrase)
  phrase_arr = phrase.split("")
  reverse_phrase = phrase_arr.reverse.join("")
  phrase == reverse_phrase
end

# def real_palindrome?(string)
  # string = string.downcase.delete('^a-z0-9')
#   palindrome?(string)
# end

puts real_palindrome?('madam') == true
puts real_palindrome?('Madam') == true           # (case does not matter)
puts real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
puts real_palindrome?('356653') == true
puts real_palindrome?('356a653') == true
puts real_palindrome?('123ab321') == false
