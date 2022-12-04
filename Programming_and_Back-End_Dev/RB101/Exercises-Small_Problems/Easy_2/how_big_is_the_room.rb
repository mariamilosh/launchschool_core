def calculate_area(len_m, wid_m)
  area_sqm = len_m * wid_m
  area_sqft = area_sqm * 10.7639
  { "sq_m" => area_sqm, "sq_f" => area_sqft }
end

puts "Enter the length of the room in meters:"
len_m = gets.chomp.to_f

puts "Enter the width of the room in meters:"
wid_m = gets.chomp.to_f

areas = calculate_area(len_m, wid_m)

puts "The area of the room is #{areas['sq_m'].round(2)} " \
     "square meters (#{areas['sq_f'].round(2)} square feet)."
