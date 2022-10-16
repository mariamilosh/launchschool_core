def rotate_array(arr)
  new_arr = []
  new_arr += arr.slice(1..-1)
  new_arr << arr[0]
end

def rotate_rightmost_digits(num, n)
  num_str = num.to_s
  (num_str.slice(0...num_str.size - n) + rotate_array(num_str.slice(-n..-1).chars).join('')).to_i
end

puts rotate_rightmost_digits(735291, 1) == 735291
puts rotate_rightmost_digits(735291, 2) == 735219
puts rotate_rightmost_digits(735291, 3) == 735912
puts rotate_rightmost_digits(735291, 4) == 732915
puts rotate_rightmost_digits(735291, 5) == 752913
puts rotate_rightmost_digits(735291, 6) == 352917
