def word_sizes(str)
  size_arr = remove_specials(str).scan(/\S+/).map { |word| word.size }
  size_h = size_arr.uniq.sort.each_with_object({}) do |s, size_h|
    size_h[s] = size_arr.count(s)
  end
end

def remove_specials(str)
  str.scan(/[\w\s]/).join
end

puts word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
puts word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
puts word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
puts word_sizes('') == {}
