def string_to_integer(num_str)
  characters = num_str.chars.map do |c|
    (0..9).find { |n| c == "#{n}"}
  end
  final_num = 0
  characters.each do |num|
    final_num = final_num * 10 + num
  end
  final_num
end

def signed_one(sign)
  sign == '-' ? -1 : 1
end

def string_to_signed_integer(num_str)
  sign = num_str.slice!(/-|\+/)
  string_to_integer(num_str) * signed_one(sign)
end

puts string_to_signed_integer('4321') == 4321
puts string_to_signed_integer('-570') == -570
puts string_to_signed_integer('+100') == 100
