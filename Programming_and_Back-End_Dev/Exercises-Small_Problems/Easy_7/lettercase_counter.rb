def letter_case_count(str)
  hsh = {}
  hsh[:lowercase] = str.scan(/[a-z]/).count
  hsh[:uppercase] = str.scan(/[A-Z]/).count
  hsh[:neither] = str.scan(/[^a-zA-Z]/).count
  hsh
end

puts letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
puts letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
puts letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
puts letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }
