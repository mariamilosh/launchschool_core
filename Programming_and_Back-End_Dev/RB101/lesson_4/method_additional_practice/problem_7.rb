statement = "The Flintstones Rock"
letter_freq = Hash.new
statement_chars = statement.split(" ").join.chars
statement_chars.each do |letter|
  letter_freq[letter] = statement_chars.count(letter)
end

p letter_freq

# result = {}
# letters = ('A'..'Z').to_a + ('a'..'z').to_a
#
# letters.each do |letter|
#   letter_frequency = statement.count(letter)
#   result[letter] = letter_frequency if letter_frequency > 0
# end
