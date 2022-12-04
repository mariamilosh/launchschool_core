def transpose(arr)
  new_arr = Array.new(arr[0].size, [])
  row_count = 0
  column_count = 0

  while row_count < arr.length do
    while column_count < arr[0].length do
      new_arr[row_count] += [arr[column_count][row_count]]
      column_count += 1
    end
    column_count = 0
    row_count += 1
  end
  new_arr
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]
