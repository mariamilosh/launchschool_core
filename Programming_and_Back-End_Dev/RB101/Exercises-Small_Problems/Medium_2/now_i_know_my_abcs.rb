LETTERS = [['B', 'O'],
           ['X', 'K'],
           ['D', 'Q'],
           ['C', 'P'],
           ['N', 'A'],
           ['G', 'T'],
           ['R', 'E'],
           ['F', 'S'],
           ['J', 'W'],
           ['H', 'U'],
           ['V', 'I'],
           ['L', 'Y'],
           ['Z', 'M']]

def block_word?(word)
  word_arr = word.upcase.chars
  matches = LETTERS.find_all do |letter_block|
    word_arr.include?(letter_block[0]) || word_arr.include?(letter_block[1])
  end
  matches.size == word_arr.size && matches.uniq == matches
end

puts block_word?('BATCH') == true
puts block_word?('BUTCH') == false
puts block_word?('jest') == true
