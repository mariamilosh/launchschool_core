def reverse_words(words)
  words.split(' ').map do |word|
    word.size >= 5 ? word.reverse : word
  end.join(' ')
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS
