words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

anagrams = []
word_hsh = {}

key_words = words.map { |word| word.chars.sort.join }.uniq

key_words.each do |letters|
  word_hsh[letters] = words.select do |word|
    letters == word.chars.sort.join
  end
end

# anagrams = word_hsh.select { |k, v| v.size > 1 }.values
anagrams = word_hsh.values

anagrams.each { |word_group| puts "#{word_group}"}
