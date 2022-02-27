# Mortgage and Car loan Calculator
#
# Ask user for: Loan amount
#               Anual Percentage Rate (APR)
#               Loan duration
#
# Calculate: Monthly interest rate
#            Loan duration in months
#            Monthly payment

def prompt(input)
  puts ">>#{input}"
end
# Convert apr to monthly interest rate
def monthly_rate(rate)
  rate.to_f / (12 * 100)
end
# Convert duration in years to months
def in_months(duration)
  duration.to_f * 12
end
# Check if a number is an integer
def integer?(num)
  num.to_i.to_s == num
end
# Check if a number is a valid integer or float
def number?(num)
  num_array = num.split(".")
  num_array.size <= 2 && integer?(num_array.first) && integer?(num_array.last)
end
# Calculate monthly loan payment
def calculate_loan(amount, rate, duration_months)
  if rate == 0
    return round_decimals(amount / duration_months.to_f)
  end
  round_decimals(amount * (monthly_rate(rate) /
  (1 - (1 + monthly_rate(rate))**(-duration_months.to_f))))
end
# Round a number to two decimal places
def round_decimals(number)
  ((number + 0.005) * 100).to_i.to_f / 100
end

loop do
  loan_amount = nil
  apr = nil
  duration_type = nil
  duration = nil
  # Allow floats
  # Verify that amount is a real number > 0
  loop do
    prompt("Enter the loan amount:")
    loan_amount = gets.chomp
    if number?(loan_amount)
      loan_amount = loan_amount.to_f
      break
    else
      prompt("Not a valid number. Please try again.")
    end
  end
  # Call monthly_rate() to convert APR to monthly rate
  # Convert interest rate to decimal
  loop do
    prompt("Enter the Annual Percentage Rate (APR).")
    apr = gets.chomp
    if number?(apr)
      apr = apr.to_f
      break
    else
      prompt("Not a valid number. Please try again.")
    end
  end
  # Ask user if they want to enter loan duration in months or years
  loop do
    prompt("Is your loan duration in months or years?")
    duration_type = gets.chomp.downcase
    if duration_type.start_with?("m")
      prompt("You chose a duration of months.")
      break
    elsif duration_type.start_with?("y")
      prompt("You chose a duration of years.")
      break
    else
      prompt("Couldn't recognize that duration type. Please try again.")
    end
  end
  # Ask user for the loan duration, then convert to months if in years
  loop do
    prompt("Enter the loan duration")
    duration = gets.chomp
    if number?(duration)
      if duration_type.start_with?("y")
        duration = in_months(duration)
      end
      break
    else
      prompt("Not a valid number. Please try again.")
    end
  end
  # Calculate the monthly payment of the loan and print the results
  monthly_payment = calculate_loan(loan_amount, apr, duration)
  prompt("Your loan payments are: $#{monthly_payment}")
  prompt("Would you like to calculate another payment? (y/n)")
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end

prompt("That's all for now!")
