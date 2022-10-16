def appears?(last_num, num_arr)
  num_arr.any?(last_num) ? "appears" : "does not appear"
end

endings = { 1 => 'st', 2 => 'nd', 3 => 'rd', 4 => 'th', 5 => "th" }
num_arr = []

(1..5).each do |num|
  puts "==> Enter the #{num}#{endings[num]} number:"
  num_arr << gets.chomp.to_i
end

puts "==> Enter the last number:"
last_num = gets.chomp.to_i

puts "The number #{last_num} #{appears?(last_num, num_arr)} in #{num_arr}."
