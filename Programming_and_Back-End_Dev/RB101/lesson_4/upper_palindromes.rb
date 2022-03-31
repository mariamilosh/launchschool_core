# PROBLEM:

# Given a string, write a method change_me which returns the same
# string but with all the words in it that are palindromes uppercased.

# change_me("We will meet at noon") == "We will meet at NOON"
# change_me("No palindromes here") == "No palindromes here"
# change_me("") == ""
# change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"

def change_me(phrase)
  words = phrase.split(" ")
  words.each do |word|
    if word == word.reverse
      word.upcase!
    end
  end
  words.join(" ")
end

puts change_me("We will meet at noon") == "We will meet at NOON"
puts change_me("No palindromes here") == "No palindromes here"
puts change_me("") == ""
puts change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"
