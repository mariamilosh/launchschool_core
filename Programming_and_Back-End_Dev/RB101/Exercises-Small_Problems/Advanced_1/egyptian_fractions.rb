def egyptian(rat_num)
  egyptian_arr = []
  multiplier = 2
  skip_one = true if rat_num.numerator < rat_num.denominator
  factors = factor(rat_num.denominator, skip_one)
  denominator = rat_num.denominator
  numerator = rat_num.numerator
  loop do
    break if numerator < 1
    if factors.empty?
      denominator *= multiplier
      numerator *= multiplier
      factors = refactor(denominator, egyptian_arr, skip_one)
      multiplier += 1
    end
    subtract_num = denominator / factors.first
    if subtract_num <= numerator
      numerator -= subtract_num
      egyptian_arr << factors.shift
    else 
      factors.shift
    end
  end
  egyptian_arr.sort
end

def unegyptian(egypt_num)
  egypt_num.map { |num| Rational(1, num) }.inject(:+)
end

def factor(num, skip_one = false)
  first_digit = skip_one ? 2 : 1
  (first_digit..num/2).to_a.keep_if { |v| num % v == 0 } + [num]
end

def refactor(num, used_denominators, skip_one = false)
  factors = factor(num, skip_one)
  factors.difference(used_denominators)
end

egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]

unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)
