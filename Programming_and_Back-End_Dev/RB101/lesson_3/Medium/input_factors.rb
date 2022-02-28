def factors(number)
  if number <= 0
    puts "Number must be greater than 0"
  else
    divisor = number
    factors = []
    loop do
      factors << number / divisor if number % divisor == 0
      divisor -= 1
      break if divisor == 0
    end
    factors
  end
end

p factors(2)
p factors(28)
p factors(-2)
p factors(0)



# def factors(number)
#   divisor = number
#   factors = []
#   while divisor > 0
#     factors << number / divisor if number % divisor == 0
#     divisor -= 1
#   end
#   factors
# end
