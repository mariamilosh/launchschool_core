require 'pry'
DIGITS = { 'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3',
           'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7',
           'eight' => '8', 'nine' => '9' }

# def word_to_digit(str)
#   new_str = str.scan(/\w+|\W+/).map do |word|
#     DIGITS.has_key?(word) ? DIGITS[word] : word
#   end.join('').gsub(/(\d)\s/, '\1\2')
#   # binding.pry
#   if new_str.scan(/\d+/)[0].size == 10
#     # new_str.gsub(/(\d\d\d)(\d\d\d)(\d\d\d\d)/, '(\1) \2-\3')
#     new_str.gsub(/(\d{3,3})(\d{3,3})(\d{4,4})/, '(\1) \2-\3')
#   else
#     new_str
#   end
# end

def word_to_digit(str)
  # put each word in array (and spaces) within array block
  # every word in DIGITS start block within array
  # iterate through blocks
  blocked_words = [[]]
  words = str.scan(/\w+|\W+/)
  # is_num_block = DIGITS.has_key?(words[0])
  # words.each do |word|
  #   # is_num_block = true if DIGITS.has_key?(word)
  #   # if DIGITS.has_key?(word)
  #   #   is_num_block = true
  #   # elsif word.match(/\S+/) && !is_num_block
  #   #   is_num_block = false
  #   #   blocked_words << []
  #   # end
  #   # blocked_words[-1] << word
  #   if is_num_block
  #     blocked_words[-1] << word
  #   end
  # end

  ## Switch bool
  is_num_block = false
  words.each do |word|
    if DIGITS.has_key?(word)
      if is_num_block
        blocked_words[-1] << word
      else
        is_num_block = true
        blocked_words << [word]
      end
    elsif is_num_block && word == ' '
      blocked_words[-1] << word
    else
      if is_num_block
        blocked_words << [word]
      else
        blocked_words[-1] << word
      end
    end
  end

  puts "#{blocked_words}"
  blocked_words.map do |b|
    if DIGITS.has_key?(b[0])
      b.join.gsub(/(\d+)/, "#{DIGITS['\1']}").scan(/[^\s]/).join
    end
    # binding.pry
  end.flatten.join
end

def phone_number?(num)
  num.size == 10
end

puts word_to_digit('Please call me at one three seven five five five one two three four. Thanks.')
# == 'Please call me at 5 5 5 1 2 3 4. Thanks.'
puts word_to_digit('Please call me at five five five one two three four. Thanks.')
# word_to_digit('Please call me at one three seven five five five one two three four. Thanks.')

# words = str.scan(/\w+|\W+/).map do |word|
#   DIGITS.has_key?(word) ? DIGITS[word] : word
# end
