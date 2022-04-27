[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# the truthiness of num.odd? is evaluated for each value in the array and
# returns true for 1. It only puts 1 because any? stops after the first truthy
# value and returns true
