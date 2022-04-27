[1, 2, 3].reject do |num|
  puts num
end

# [1, 2, 3] because the line returned is a puts which returns nil each time so
# no values in the array are rejected
