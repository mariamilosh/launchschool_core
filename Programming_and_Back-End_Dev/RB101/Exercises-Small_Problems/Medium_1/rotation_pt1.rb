def rotate_array(arr)
  new_arr = []
  new_arr += arr.slice(1..-1)
  new_arr << arr[0]
end

puts rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
puts rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
puts rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
puts rotate_array(x) == [2, 3, 4, 1]   # => true
puts x == [1, 2, 3, 4]                 # => true

def rotate_string(str)
  rotate_array(str.chars).join('')
end

def rotate_integer(num)
  rotate_string(num.to_s).to_i
end

puts rotate_string('abcde') == 'bcdea'
puts rotate_string('this is a string') == 'his is a stringt'
puts rotate_integer(7086) == 867
puts rotate_integer(28723) == 87232
