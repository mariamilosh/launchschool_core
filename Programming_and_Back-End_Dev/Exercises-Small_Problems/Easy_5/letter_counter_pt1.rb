def word_sizes(phrase)
  size_arr = phrase.scan(/\S+/).map { |word| word.size }
  size_h = size_arr.uniq.sort.each_with_object({}) do |s, size_h|
    size_h[s] = size_arr.count(s)
  end
end

puts word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
puts word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1,
                                                              7 => 2 }
puts word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
puts word_sizes('') == {}
