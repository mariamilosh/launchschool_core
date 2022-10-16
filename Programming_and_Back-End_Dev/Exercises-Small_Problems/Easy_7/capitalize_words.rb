def word_cap(str)
  str.split.map do |word|
    lower_case = word.downcase
    title_case = lower_case[0].upcase + lower_case.slice(1..-1)
  end.join(" ")
end

puts word_cap('four score and seven') == 'Four Score And Seven'
puts word_cap('the javaScript language') == 'The Javascript Language'
puts word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'
