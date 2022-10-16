def buy_fruit(arr)
  arr.flat_map do |fruit|
    [fruit[0]] * fruit[1]
  end
end

puts buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]

def buy_fruit(arr)
  fruit_arr = []
  arr.each do |fruit|
    fruit_arr += [fruit[0]] * fruit[1]
  end
  fruit_arr
end

puts buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]
