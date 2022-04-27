{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# returns an array with [nil, "bear"]
# map evaluates each value in the hash and returns it in an array.
# The first value is nil because it is not > 3. The second is "bear" because
# it is > 3
