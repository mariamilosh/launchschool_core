def leap_year?(year)
  (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0) ? true : false
end

puts leap_year?(2016) == true
puts leap_year?(2015) == false
puts leap_year?(2100) == false
puts leap_year?(2400) == true
puts leap_year?(240000) == true
puts leap_year?(240001) == false
puts leap_year?(2000) == true
puts leap_year?(1900) == false
puts leap_year?(1752) == true
puts leap_year?(1700) == false
puts leap_year?(1) == false
puts leap_year?(100) == false
puts leap_year?(400) == true


# It is better to test if divisible by 400 first since it doesn't require any
#   other condition to be true. Then test if not divisible by 100 and
#   lastly test if divisible by 4. More numbers are divisible by 4 than
#   either of the other conditions so it eliminates more numbers to test those
#   first.
