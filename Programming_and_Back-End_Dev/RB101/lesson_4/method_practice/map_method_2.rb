[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# [1, nil, nil] Any value > 1 evaluates to nil because of puts. Any value not
# > 1 is returned
