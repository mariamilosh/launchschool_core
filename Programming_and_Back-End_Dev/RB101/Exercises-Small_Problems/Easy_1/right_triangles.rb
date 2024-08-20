# def triangle(width)
#     (1..width).each do |row|
#         empty_spaces = width - row
#         print " " * empty_spaces
#         puts "*" * row
#     end
#     puts ""
# end

# def upside_down_triangle(width)
#     (0..width).each do |row|
#         stars = width - row
#         print " " * row
#         puts "*" * stars
#     end
#     puts ""
# end


# ****************************************************

def triangle_rows(width)
  (1..width).map do |row|
      " " * (width - row) + "*" * row
  end
end

def flip_x_axis(triangle_arr)
  triangle_arr.map do |row|
    row.reverse
  end
end

def flip_y_axis(triangle_arr)
  triangle_arr.reverse
end

def triangle_orientation(triangle_arr, orientation)
  case orientation
  when :top_right
      flip_y_axis(triangle_arr)
  when :top_left
      flip_y_axis(flip_x_axis(triangle_arr))
  when :bottom_right
      triangle_arr
  when :bottom_left
      flip_x_axis(triangle_arr)
  end
end

def triangle(width, orientation = :bottom_right)
  triangle_arr = triangle_orientation(triangle_rows(width), orientation)
  triangle_arr.each{ |row| puts row }
end

triangle(5)
triangle(9)
triangle(5, :top_right)
triangle(9, :bottom_left)
triangle(9, :top_left)
