# def fizzbuzz(num1, num2)
#   (num1..num2).map do |n|
#     if n % 3 == 0
#       "Fizz"
#     end
#     if n % 5 == 0
#       "Buzz"
#     end
#     if n % 3 != 0 && n % 5 != 0
#       n
#     end
#     print " "
#   end
# end

def fizzbuzz(num1, num2)
  result = []
  (num1..num2).each do |n|
    if n % 3 == 0 && n % 5 == 0
      result << "FizzBuzz"
    elsif n % 3 == 0
      result << "Fizz"
    elsif n % 5 == 0
      result << "Buzz"
    else
      result << n
    end
  end
  result.join(', ')
end

puts "#{fizzbuzz(1, 15)}" # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz
