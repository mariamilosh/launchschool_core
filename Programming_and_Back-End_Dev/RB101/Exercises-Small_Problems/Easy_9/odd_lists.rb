def oddities(arr)
  odds_arr = []
  arr.each_index do |i|
    odds_arr << arr[i] if i % 2 == 0
  end
  odds_arr
end

def oddities(arr)
  arr.map.with_index do |num, i|
    num if i.even? 
  end.compact
end

def oddities(arr)
  arr.keep_if.with_index do |_num, i|
    i.even? 
  end
end

def evenities(arr)
  evenities_arr = []
  arr.each_index do |i|
    evenities_arr << arr[i] unless i % 2 == 0
  end
  evenities_arr
end

oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
oddities(['abc', 'def']) == ['abc']
oddities([123]) == [123]
oddities([]) == []
oddities([1, 2, 3, 4, 1]) == [1, 3, 1]

evenities([2, 3, 4, 5, 6])
evenities([1, 2, 3, 4, 5, 6])
evenities(['abc', 'def'])
evenities([123])
evenities([])
evenities([1, 2, 3, 4, 1])
