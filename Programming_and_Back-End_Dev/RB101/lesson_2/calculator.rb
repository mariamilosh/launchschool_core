# ask user for two numbers
# ask user for operation to perform
# perform the operation on the two numbers
# output the result
def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt("Welcome to Calculator! Enter your name:")
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Make sure you use a valid name.")
  else
    break
  end
end
prompt("Hey, #{name}!")
loop do # main loop
  num1 = nil
  num2 = nil

  loop do
    prompt("Enter a number:")
    num1 = gets.chomp.to_i

    if valid_number?(num1)
      break
    else
      prompt("That doesn't look like a valid number")
    end
  end
  loop do
    prompt("Enter a number:")
    num2 = gets.chomp.to_i

    if valid_number?(num2)
      break
    else
      prompt("That doesn't look like a valid number")
    end
  end

  operator_prompt = <<-MSG
What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)
  operator = nil
  loop do
    operator = Kernel.gets().chomp().downcase()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3, or 4")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")
  result = case operator
           when '1'
             num1 + num2
           when '2'
             num1 - num2
           when '3'
             num1 * num2
           when '4'
             num1.to_f / num2.to_f
           end
  prompt("The result is #{result}")
  prompt("Do you want to perform another calculation?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using calculator")
