def leading_substrings(str)
  ch_arr = []
  str.chars.each_with_index do |ch, i|
    ch_arr << str.chars.slice(0..i).join
  end
  ch_arr
end

def substrings(str)
  str_arr = []
  (0...str.length).each do |i|
    str_arr += leading_substrings(str[i...str.length])
  end
  str_arr
end

puts substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]
