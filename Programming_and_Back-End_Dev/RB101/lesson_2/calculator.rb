# ask user for two numbers
# ask user for operation to perform
# perform the operation on the two numbers
# output the result

puts("Welcome to Calculator!")
puts "Enter a number:"
num_1 = gets.chomp.to_i

puts "Enter another number:"
num_2 = gets.chomp.to_i

loop do
  puts "Operation type? (add, subtract, multiply, divide)"
  op_type = gets.chomp.downcase

  if op_type == 'add'
    result = num_1 + num_2
    puts "#{num_1} + #{num_2} = #{result}"
    break
  elsif op_type == 'subtract'
    result = num_1 - num_2
    puts "#{num_1} - #{num_2} = #{result}"
    break
  elsif op_type == 'multiply'
    result = num_1 * num_2
    puts "#{num_1} * #{num_2} = #{result}"
    break
  elsif op_type == 'divide'
    result = num_1.to_f / num_2.to_f
    puts "#{num_1} / #{num_2} = #{result}"
    break
  else
    puts "Operation type not valid. Please try again."
  end
end
