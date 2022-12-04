def neutralize(sentence)
  words = sentence.split(' ')
  # words.each do |word|
  #   words.delete(word) if negative?(word)
  # end
  good_words = []
  words.each do |word|
    good_words << word if !negative?(word)
  end

  # words.join(' ')
  good_words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.


# Should not change object while iterating block because indexes shift and length
# of object changes
