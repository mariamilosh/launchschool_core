def multiply_all_pairs(arr1, arr2)
  prod_arr = []
  arr1.each do |a|
    arr2.each { |b| prod_arr << a * b }
  end
  prod_arr.sort
end

puts multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]
