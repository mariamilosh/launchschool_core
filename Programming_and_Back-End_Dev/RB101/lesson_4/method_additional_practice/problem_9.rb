def titleize(str)
  str_arr = str.split(" ")
  str_arr.each do |word|
    word.capitalize!
  end
  str_arr.join(" ")
end

words = "the flintstones rock"
p titleize(words)

# words.split.map { |word| word.capitalize }.join(' ')
