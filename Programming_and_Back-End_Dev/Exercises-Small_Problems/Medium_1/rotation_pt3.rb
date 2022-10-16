def rotate_array(arr)
  new_arr = []
  new_arr += arr.slice(1..-1)
  new_arr << arr[0]
end

def rotate_rightmost_digits(num, n)
  num_str = num.to_s
  (num_str.slice(0...num_str.size - n) + rotate_array(num_str.slice(-n..-1).chars).join('')).to_i
end

def max_rotation(num)
  rotated_num = num
  (0...num.to_s.size).each do |i|
    rotated_num = rotate_rightmost_digits(rotated_num, num.to_s.size - i)
  end
  rotated_num
end

puts max_rotation(735291) == 321579
puts max_rotation(3) == 3
puts max_rotation(35) == 53
puts max_rotation(105) == 15 # the leading zero gets dropped
puts max_rotation(8_703_529_146) == 7_321_609_845

def rotate_rightmost_vals(arr, n)
  arr[0...arr.size - n] + rotate_array(arr[-n..-1])
end

def max_rotation(num)
  rotated_arr = num.to_s.chars
  (0...rotated_arr.size).each do |i|
    rotated_arr = rotate_rightmost_vals(rotated_arr, rotated_arr.size - i)
  end
  rotated_arr.join.to_i
end

puts max_rotation(735291) == 321579
puts max_rotation(3) == 3
puts max_rotation(35) == 53
puts max_rotation(105) == 15 # the leading zero gets dropped
puts max_rotation(8_703_529_146) == 7_321_609_845
puts max_rotation(700291)
puts max_rotation(1460005)
