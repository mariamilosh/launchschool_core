def palindromic_number?(num)
  num.to_s == num.to_s.reverse
end

puts palindromic_number?(34543) == true
puts palindromic_number?(123210) == false
puts palindromic_number?(22) == true
puts palindromic_number?(5) == true

# Numbers starting with 0 are octal numbers and are automatically
#   converted to base 10 before the program handles them. Octals
#   are therefore indistinguishable from base 10. An integer can
#   be converted into an octal string using to_s(8). A numeric string
#   can be converted to octal using to_i(8). An int can also be
#   converted to an octal string using sprintf or '0%o' % num.
#   This also adds the leading zero.
