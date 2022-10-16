def twice(num)
  num_str = num.to_s
  if num_str[0...(num_str.size / 2)] ==
     num_str[(num_str.size / 2)...num_str.size]
    num
  else
    num * 2
  end
end

# num.to_s.scan(/(\d+)+\1/)

puts twice(37) == 74
puts twice(44) == 44
puts twice(334433) == 668866
puts twice(444) == 888
puts twice(107) == 214
puts twice(103103) == 103103
puts twice(3333) == 3333
puts twice(7676) == 7676
puts twice(123_456_789_123_456_789) == 123_456_789_123_456_789
puts twice(5) == 10


# "3333".scan(/((\d+){,2})\1/)
# "103103".scan(/((\d+)+)\1/)
# "3333".scan(/((\d+)+)\1/)
# "7676".scan(/((\d+)+)\1/)
# "444".scan(/((\d+)+)\1/)
