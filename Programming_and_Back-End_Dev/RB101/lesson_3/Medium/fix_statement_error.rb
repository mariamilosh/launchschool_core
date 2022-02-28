# puts "the value of 40 + 2 is " + (40 + 2)
# Errors because (40 + 2) is an integer and it cannot mix types with string

puts "the value of 40 + 2 is #{40 + 2}"

puts "the value of 40 + 2 is " + (40 + 2).to_s
