def show_multiplicative_average(arr)
  print "The result is "
  puts "%0.3f" % (arr.inject(1.0) { |sum, num| sum *= num } / arr.size)
end

show_multiplicative_average([3, 5])                # => The result is 7.500
show_multiplicative_average([6])                   # => The result is 6.000
show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667
