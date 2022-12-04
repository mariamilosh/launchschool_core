def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([]) # => []
p my_method([3]) # => [21]
p my_method([3, 4]) # => [9, 16]
p my_method([5, 6, 7]) # => [25, 36, 49]

# elsif has no comparison operation so it is bound to array.map
# Since array.map returns an array, it has a truthy value and thus
# evaluates to true for every method call except when the array
# is empty
# The elsif contains nothing other than #map and there is no value
# after it so nil is returned when the method runs
