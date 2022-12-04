# input: array of arrays of integers
# output: new array of arrays of integers
#
# matrix can be any dimensions, provided that those dimensions
# form a rectangle
#
# a matrix rotated clockwise has the last row of the outer array as
# the first column, followed by the second row array, and then the
# first row array as the last column
# this pattern is the same as the transpose method except that
# the outer array elements are reversed
#
# call the transpose method within the rotate90 method with the
# argument set as the reverse of the matrix

def transpose(arr)
  new_arr = Array.new(arr[0].size, [])

  arr.each do |a|
    a.each_with_index do |n, i|
      new_arr[i] += [n]
    end
  end
  new_arr
end

def rotate90(matrix)
  transpose(matrix.reverse)
end

def rotate180(matrix)
  rotate90(rotate90(matrix))
end

def rotate270(matrix)
  rotate180(rotate90(matrix))
end

def rotate360(matrix)
  rotate270(rotate90(matrix))
end

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix90 = [
  [3, 4, 1],
  [9, 7, 5],
  [6, 2, 8]
]
p rotate90(matrix1)

matrix180 = [
  [6, 9, 3],
  [2, 7, 4],
  [8, 5, 1]
]
p rotate180(matrix1)

matrix270 = [
  [8, 2, 6],
  [5, 7, 9],
  [1, 4, 3]
]
p rotate270(matrix1)

matrix360 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]
p rotate360(matrix1)

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))
# new_matrix4 = rotate360(matrix1)
# new_matrix5 = rotate360(matrix2)

#
# p new_matrix1
# # == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
# p new_matrix2
# # == [[5, 3], [1, 7], [0, 4], [8, 2]]
# p new_matrix3
# # == matrix2
# p new_matrix4
# p new_matrix5
