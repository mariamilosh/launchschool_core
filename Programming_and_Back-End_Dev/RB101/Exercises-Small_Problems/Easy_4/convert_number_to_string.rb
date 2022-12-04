NUMS = { 0 => '0' , 1 => '1', 2 => '2', 3 => '3', 4 => '4',
         5 => '5', 6 => '6', 7 => '7', 8 => '8', 9 => '9'}

def integer_to_string(num)
  result = num.divmod(10)
  num_str_arr = [result[1]]
  while result[0] != 0 do
    result = result[0].divmod(10)
    num_str_arr.unshift(result[1])
  end
  num_str_arr.join
end

puts integer_to_string(4321) == '4321'
puts integer_to_string(0) == '0'
puts integer_to_string(5000) == '5000'

def integer_to_string(num)
  result = num.divmod(10)
  num_str = ""
  num_str.insert(0, NUMS[result[1]])
  while result[0] != 0 do
    result = result[0].divmod(10)
    num_str.insert(0, NUMS[result[1]])
  end
  num_str
end

puts integer_to_string(4321) == '4321'
puts integer_to_string(0) == '0'
puts integer_to_string(5000) == '5000'
