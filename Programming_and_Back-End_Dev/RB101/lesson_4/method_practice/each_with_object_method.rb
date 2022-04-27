['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

# It returns a new hash object {'a'=>'ant'=>'b': 'bear', 'c'=>'cat'} because it
# is setting the key as the first character of each value in the array and the
# hash value to the array value. 
