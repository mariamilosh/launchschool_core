def leading_substrings(str)
  ch_arr = []
  str.chars.each_with_index do |ch, i|
    ch_arr << str.chars.slice(0..i).join
  end
  ch_arr
end

puts leading_substrings('abc') == ['a', 'ab', 'abc']
puts leading_substrings('a') == ['a']
puts leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']
