def halvsies(arr)
  split_arr = []
  split_arr << arr.take((arr.size/2.0).ceil)
  split_arr << arr.drop((arr.size/2.0).ceil)
end

puts "#{halvsies([1, 2, 3, 4])}"
# == [[1, 2], [3, 4]]
puts "#{halvsies([1, 5, 2, 4, 3])}"
# == [[1, 5, 2], [4, 3]]
puts "#{halvsies([5])}"
# == [[5], []]
puts halvsies([]) == [[], []]
