def swap_name(name_str)
  # name_str.gsub(/(\w+)\s(\w+)/, "#{$2}, #{$1}")
  # name_str.gsub(/(\w+)\s(\w+)/, $2 + ', ' + $1)
  name_arr = name_str.split
  name_arr[1] + ', ' + name_arr[0]
end

puts swap_name('Joe Roberts') == 'Roberts, Joe'
