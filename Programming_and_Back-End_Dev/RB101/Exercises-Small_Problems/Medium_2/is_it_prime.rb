def is_prime(num)
  return false if num == 1
  (2...num).each do |n|
    return false if num % n == 0
  end
  true
end

puts(is_prime(1) == false)              # true
puts(is_prime(2) == true)               # true
puts(is_prime(3) == true)               # true
puts(is_prime(4) == false)              # true
puts(is_prime(5) == true)               # true
puts(is_prime(6) == false)              # true
puts(is_prime(7) == true)               # true
puts(is_prime(8) == false)              # true
puts(is_prime(9) == false)              # true
puts(is_prime(10) == false)             # true
puts(is_prime(23) == true)              # true
puts(is_prime(24) == false)             # true
puts(is_prime(997) == true)             # true
puts(is_prime(998) == false)            # true
puts(is_prime(3_297_061) == true)       # true
puts(is_prime(23_297_061) == false)     # true
