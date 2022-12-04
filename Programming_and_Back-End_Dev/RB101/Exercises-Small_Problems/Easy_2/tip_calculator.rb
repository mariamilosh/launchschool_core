print "What is the bill? "
bill = gets.chomp.to_f

print "What is the tip percentage? "
tip_percentage = gets.chomp.to_f
puts ""

tip = (bill * tip_percentage/100).round(2)
total = tip + bill.round(2)

puts "The tip is $#{tip}"
puts "The total is $#{total}"
