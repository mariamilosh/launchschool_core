def repeater(str)
  str.gsub(/(.)/, '\1\1')
end

puts repeater('Hello') == "HHeelllloo"
puts repeater("Good job!") == "GGoooodd  jjoobb!!"
puts repeater('') == ''
