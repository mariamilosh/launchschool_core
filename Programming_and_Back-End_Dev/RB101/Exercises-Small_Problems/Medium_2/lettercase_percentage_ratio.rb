def letter_percentages(str)
  count_hsh = {}
  count_hsh[:lowercase] = ((str.scan(/[a-z]/).size * 100.0) / str.size).round(1)
  count_hsh[:uppercase] = ((str.scan(/[A-Z]/).size * 100.0) / str.size).round(1)
  count_hsh[:neither] = ((str.scan(/[^A-Za-z]/).size * 100.0) / str.size).round(1)
  count_hsh
end

puts letter_percentages('abCdef 123')
# == { lowercase: 50.0, uppercase: 10.0, neither: 40.0 }
puts letter_percentages('AbCd +Ef')
# == { lowercase: 37.5, uppercase: 37.5, neither: 25.0 }
puts letter_percentages('123')
# == { lowercase: 0.0, uppercase: 0.0, neither: 100.0 }
puts letter_percentages('abcdefGHI')
