ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

total = 0

ages.each do |key, age|
  total += age
end

puts total

# ages.values.inject(:+) # => 6174
