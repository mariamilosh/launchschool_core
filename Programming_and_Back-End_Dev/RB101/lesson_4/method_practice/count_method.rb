['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

# returns 2 because it is counting the number of truthy values and only the
# length of 'ant' and 'bat' is < 4
