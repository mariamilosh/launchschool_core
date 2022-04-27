arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]
#[[1, 8, 3], [1, 5, 9], [6, 1, 7], [1, 6, 9]]
arr.sort_by! do |element|
  element.select do |num|
    num % 2 != 0
  end
end

p arr
