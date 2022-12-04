def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    # reversed_words = words[i] + reversed_words  # tries to combine string with array
    reversed_words.unshift(words[i])
    i += 1
  end

  reversed_words.join(' ')
end

p reverse_sentence('how are you doing')
# expected output: 'doing you are how'
