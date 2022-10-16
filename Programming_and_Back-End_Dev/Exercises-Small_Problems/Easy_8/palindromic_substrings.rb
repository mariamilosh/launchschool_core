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

def palindromes(str)
  substrings(str).select do |sub_str|
    sub_str.length > 1 && sub_str == sub_str.reverse
  end
end

puts palindromes('abcd') == []
puts palindromes('madam') == ['madam', 'ada']
puts palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
puts palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]
