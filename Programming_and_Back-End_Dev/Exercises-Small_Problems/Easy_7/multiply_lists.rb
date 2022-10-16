def multiply_list(arr1, arr2)
  arr1.zip(arr2).map { |num_pair| num_pair[0] * num_pair[1] }
end

puts multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]
