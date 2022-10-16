def string_to_integer(str)
  characters = str.chars.map do |c|
    (0..9).find { |n| c == "#{n}"}
  end
  final_num = 0
  characters.each do |num|
    final_num = final_num * 10 + num
  end
  final_num
end

puts string_to_integer('4321') == 4321
puts string_to_integer('570') == 570

HEX_NUMS = { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5,
             '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'A' => 10, 'B' => 11,
             'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15 }

def hexadecimal_to_integer(hex_str)
  hex_chars = hex_str.chars
  int_nums = hex_chars.map do |c|
    HEX_NUMS[c.upcase]
  end
  int_nums.inject do | total, n |
    total = total * 16 + n
  end
end

puts hexadecimal_to_integer('4D9f') == 19871
