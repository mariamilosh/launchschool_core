def running_total(num_arr)
  (0...num_arr.size).map { |i| num_arr[0..i].sum }
end

puts running_total([2, 5, 13]) == [2, 7, 20]
puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total([3]) == [3]
puts running_total([]) == []

def running_total(num_arr)
  num_arr.inject([]) do |result, n|
    if result.empty?
      result << n
    else
      result << n + result.last
    end
  end
end

puts running_total([2, 5, 13]) == [2, 7, 20]
puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total([3]) == [3]
puts running_total([]) == []
