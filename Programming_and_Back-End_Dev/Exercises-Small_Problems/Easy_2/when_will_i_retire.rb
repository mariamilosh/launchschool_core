print "What is your age? "
age = gets.chomp.to_i

print "At what age would you like to retire? "
retire_age = gets.chomp.to_i

age_dif = retire_age - age

curr_time = Time.now
curr_year = curr_time.year
retire_year = (curr_time + (60*60*24*365*age_dif)).year

puts ""
puts "It's #{curr_year}. You will retire in #{retire_year}."
puts "You have only #{age_dif} years of work to go!"
