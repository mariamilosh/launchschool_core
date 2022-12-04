def decrease(counter)
  counter - 1
end

counter = 10

# 10.times do
#   puts counter
#   counter = decrease(counter)
# end

while counter >= 1 do
  puts counter
  counter = decrease(counter)
end

puts 'LAUNCH!'
