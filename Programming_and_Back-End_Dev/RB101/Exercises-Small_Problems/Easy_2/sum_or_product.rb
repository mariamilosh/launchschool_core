def calculate_product(num)
  prod = 1
  (1..num).each do |n|
     prod = prod * n
  end
  prod
end

def calculate_sum(num)
  (1..num).sum
end

def calculate(op, num)
  if op == 's'
    calculate_sum(num)
  elsif op == 'p'
    calculate_product(num)
  end
end

op_types = { 's' => 'sum', 'p' => 'product' }

puts ">> Please enter an integer greater than 0:"
num = gets.chomp.to_i

puts ">> Enter 's' to compute the sum, 'p' to compute the product."
op = gets.chomp

puts "The #{op_types[op]} of the integers between 1 " + \
     "and #{num} is #{calculate(op, num)}."
