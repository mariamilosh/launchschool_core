def stringy(num)
  i = '0'
  (1..num).map do
    i == '0' ? i = '1' : i = '0'
  end.join('')
end


puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'
