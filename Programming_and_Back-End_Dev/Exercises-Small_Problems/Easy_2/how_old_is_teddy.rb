def print_age(name)
  name  = 'Teddy' if name.empty?
  puts "#{name} is #{rand(20..200)} years old!"
end

def ask_for_name
  puts "What is your name?"
  gets.chomp
end

name = ask_for_name
print_age(name)
