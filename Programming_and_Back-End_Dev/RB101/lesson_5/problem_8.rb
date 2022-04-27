hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'],
  fourth: ['over', 'the', 'lazy', 'dog']}

vowels = 'aeiouAEIOU'.chars
hsh.each do |arr, words|
  words.each do |word|
    word.chars.each do |char|
      puts char if vowels.include?(char)
    end
  end
end
