def triangle(num)
  num.times do |i|
    (num - i - 1).times { print ' ' }
    (i + 1).times { print '*' }
    puts ""
  end
end

triangle(5)
triangle(9)

#     *
#    **
#   ***
#  ****
# *****
